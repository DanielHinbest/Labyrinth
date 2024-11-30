import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Marble extends BodyComponent {
  @override
  final Vector2 position;
  late CircleShape shape;
  late Fixture fixture;

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
}
