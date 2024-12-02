import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'marble.dart';

class Hole extends BodyComponent {
  final Vector2 center;
  final double radius;

  Hole({required this.center, required this.radius});

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = center;

    final body = world.createBody(bodyDef);
    body.userData = this; // Set userData to this Hole instance

    final circleShape = CircleShape()..radius = radius;

    body.createFixture(FixtureDef(circleShape)..isSensor = true);

    return body;
  }

  @override
  void onMount() {
    super.onMount();
    print('Hole mounted with body: $body');
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0xFFFF0000) // Changed to red for better visibility
      ..style = PaintingStyle.fill;

    // Use the body's position for rendering
    final bodyPosition = body.position;
    final screenPosition = worldToScreen(bodyPosition);

    canvas.drawCircle(
        Offset(screenPosition.x, screenPosition.y), radius, paint);
  }

  // Helper method to convert world coordinates to screen coordinates
  Vector2 worldToScreen(Vector2 worldPosition) {
    return worldPosition * 0.0; // Adjust the scaling factor as needed
  }
}
