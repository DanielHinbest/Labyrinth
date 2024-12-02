import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'marble.dart';

class Goal extends BodyComponent {
  final Vector2 center;
  final double radius;

  Goal({required this.center, required this.radius});

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = center;

    final body = world.createBody(bodyDef);
    body.userData = this; // Set userData to this Goal instance

    final circleShape = CircleShape()..radius = radius;

    body.createFixture(FixtureDef(circleShape)..isSensor = true);

    return body;
  }

  @override
  void onMount() {
    super.onMount();
    print('Goal mounted with body: $body');
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0xFF00FF00) // Green color for the goal
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

  // Method to change marble color to rainbow
  void changeMarbleColorToRainbow(Marble marble) {
    marble.changeColorToRainbow();
  }
}
