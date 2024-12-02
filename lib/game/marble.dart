import 'dart:async';
import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Marble extends BodyComponent {
  @override
  final Vector2 position;
  late CircleShape shape;
  late Fixture fixture;
  StreamSubscription? _accelerometerSubscription;

  Marble(this.position);

  @override
  Body createBody() {
    shape = CircleShape()..radius = 5.0;
    final fixtureDef = FixtureDef(shape)
      ..density = 1.0
      ..restitution = 0.0
      ..friction = 0.0;

    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.dynamic;

    final body = world.createBody(bodyDef);
    body.userData = this; // Set userData to this Marble instance
    fixture = body.createFixture(fixtureDef);
    return body;
  }

  @override
  void onMount() {
    super.onMount();
    print('Marble mounted with body: $body');
    _startAccelerometer();
  }

  void _startAccelerometer() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      // Update the marble's velocity based on the accelerometer data
      final Vector2 velocity = Vector2(event.y, event.x) * 10;
      body.linearVelocity = velocity;
    });
  }

  @override
  void onRemove() {
    super.onRemove();
    _accelerometerSubscription?.cancel();
  }

  void shrinkAndDisappear() {
    const int steps = 20;
    const double shrinkFactor = 0.05;
    double currentRadius = shape.radius;

    // Slow down marble
    body.linearVelocity = body.linearVelocity * 0.5;

    for (int i = 0; i < steps; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (currentRadius > 0) {
          currentRadius -= shrinkFactor;
          if (currentRadius < 0.1) {
            currentRadius = 0.1; // Ensure the radius does not become too small
          }
          shape.radius = currentRadius;
          fixture.shape = shape;
          // Ensure the marble's position and size are valid
          body.setTransform(body.position, body.angle);
        } else {
          if (world != null) {
            world.destroyBody(body);
          }
        }
      });
    }
  }

  // Method to change color to rainbow
  void changeColorToRainbow() {
    paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xFFFF0000), // Red
          Color(0xFFFF7F00), // Orange
          Color(0xFFFFFF00), // Yellow
          Color(0xFF00FF00), // Green
          Color(0xFF0000FF), // Blue
          Color(0xFF4B0082), // Indigo
          Color(0xFF8B00FF), // Violet
        ],
      ).createShader(Rect.fromLTWH(0.0, 0.0, 100.0, 100.0));
  }
}
