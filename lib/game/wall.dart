import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class Wall extends BodyComponent {
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
        points.add(Vector2(pos.dx, pos.dy));
      }

      for (int j = 0; j < points.length - 1; j++) {
        final edgeShape = EdgeShape()
          ..set(points[j], points[j + 1]);
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
    final paint = Paint()
      ..color = const Color(0xFFAAAAAA)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }
}
