import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Marble extends BodyComponent {
  @override
  final Vector2 position;

  Marble(this.position);

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 10.0;
    final fixtureDef = FixtureDef(shape)
      ..density = 1.0
      ..restitution = 0.0
      ..friction = 0.0;

    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.dynamic;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
