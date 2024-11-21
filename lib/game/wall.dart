import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class Wall extends BodyComponent {
  // CONSTANTS
  static const double SCALE = 0.1;
  static const double TRANSLATE_X = -24.0;
  static const double TRANSLATE_Y = -9.0;
  final Path path;

  Wall({required this.path});

  static Wall fromString(String path) {
    return Wall(path: parseSvgPath(path));
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef()..type = BodyType.static;

    final body = world.createBody(bodyDef);

    for (final metric in path.computeMetrics()) {
      final points = <Vector2>[];
      for (double i = 0; i < metric.length; i += 2) {
        final pos = metric.getTangentForOffset(i)!.position;
        points.add(Vector2(
            pos.dx * SCALE + TRANSLATE_X, pos.dy * SCALE + TRANSLATE_Y));
      }

      for (int j = 0; j < points.length - 1; j++) {
        final edgeShape = EdgeShape()..set(points[j], points[j + 1]);
        body.createFixture(FixtureDef(edgeShape)
          ..density = 1.0
          ..friction = 0.5
          ..restitution = 0.2);
      }
    }
    return body;
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(TRANSLATE_X, TRANSLATE_Y);
    canvas.scale(SCALE, SCALE);

    final paint = Paint()
      ..color = const Color(0xFFAAAAAA)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
    canvas.restore();
  }
}
