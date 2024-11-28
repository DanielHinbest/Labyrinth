import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'marble.dart';

class Hole extends BodyComponent {
  // CONSTANTS
  static const double SCALE = 1.0;
  static const double TRANSLATE_X = 0.0;
  static const double TRANSLATE_Y = 0.0;
  final Vector2 center;
  final double radius;

  Hole({required this.center, required this.radius});

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = Vector2(
        center.x * SCALE + TRANSLATE_X,
        center.y * SCALE + TRANSLATE_Y,
      );

    final body = world.createBody(bodyDef);
    body.userData = this; // Set userData to this Hole instance

    final circleShape = CircleShape()..radius = radius * SCALE;

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
    canvas.save();
    canvas.translate(
      center.x * SCALE + TRANSLATE_X,
      center.y * SCALE + TRANSLATE_Y,
    );
    canvas.scale(SCALE, SCALE);

    final paint = Paint()
      ..color = const Color(0xFFFF0000) // Changed to red for better visibility
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, radius, paint);
    canvas.restore();
  }
}
