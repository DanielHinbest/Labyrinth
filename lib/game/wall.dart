import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class Wall extends PositionComponent with CollisionCallbacks {
  final Path path;
  PolygonHitbox? hitbox;

  Wall({required this.path});

  static Wall fromString(String path) {
    return Wall(path: parseSvgPath(path));
  }

  void loadHitbox() {
    /// Test if the hitbox has already been loaded, no need to load it again
    if (hitbox != null) return;

    final points = <Vector2>[];
    path.computeMetrics().forEach((metric) {
      for (var i = 0; i < metric.length; i++) {
        final pos = metric.getTangentForOffset(i.toDouble())!.position;
        points.add(Vector2(pos.dx, pos.dy));
      }
    });
    hitbox = PolygonHitbox(points);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawPath(path, paint);
  }
}
