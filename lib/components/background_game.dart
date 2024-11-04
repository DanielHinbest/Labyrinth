import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BackgroundGame extends FlameGame {
  final Random random = Random();

  @override
  Color backgroundColor() => Colors.grey[200]!;

  /// Set background color

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final dotSize = random.nextDouble() * 10 + 5;

    /// Random dot size
    final dotCount = random.nextInt(max(10, size.x * size.y ~/ 10000)) + 20;

    /// Random dot count

    /// Add randomly positioned dots with random velocities
    for (int i = 0; i < dotCount; i++) {
      add(DotComponent(
        position: Vector2(
          random.nextDouble() * size.x,
          random.nextDouble() * size.y,
        ),
        dotSize: dotSize,
        velocity: Vector2(
          (random.nextDouble() - 0.5) * 20,

          /// Random x velocity
          (random.nextDouble() - 0.5) * 20,

          /// Random y velocity
        ),
      ));
    }
  }
}

class DotComponent extends PositionComponent with HasGameRef<BackgroundGame> {
  final double dotSize;
  final Vector2 velocity;

  DotComponent({
    required Vector2 position,
    required this.dotSize,
    required this.velocity,
  }) {
    this.position = position;
    size = Vector2.all(dotSize);
  }

  @override
  void update(double dt) {
    super.update(dt);

    /// Update the position based on velocity and delta time
    position += velocity * dt;

    /// Wrap the dots around the screen edges
    if (position.x < 0) position.x = gameRef.size.x;
    if (position.x > gameRef.size.x) position.x = 0;
    if (position.y < 0) position.y = gameRef.size.y;
    if (position.y > gameRef.size.y) position.y = 0;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.grey[400]!;

    /// Dot color
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
