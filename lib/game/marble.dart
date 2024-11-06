import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'wall.dart';

class Marble extends PositionComponent with CollisionCallbacks {
  Vector2 velocity = Vector2(50, 50);
  bool hasCollided = false; // Flag to manage collision response timing

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!hasCollided) {
      position.add(velocity * dt);
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
<<<<<<< HEAD
    if (other is Wall) {
      /// TODO: Add collision logic
=======
    if (other is Wall && !hasCollided) {
      hasCollided = true;
      velocity = -velocity * 0.9;
>>>>>>> main
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Wall) {
      hasCollided = false;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(
        Offset(position.x, position.y), 10, Paint()..color = Colors.white);
  }
}
