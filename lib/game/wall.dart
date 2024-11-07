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

  @override
  Future<void> onLoad() async {
    loadHitbox();
    if (hitbox != null) {
      add(hitbox!);
    }
  }

  void loadHitbox() {
    if (hitbox != null) return;

    final points = <Vector2>[];
    for (var metric in path.computeMetrics()) {
      for (double i = 0; i < metric.length; i += 5) {
        final pos = metric.getTangentForOffset(i)!.position;
        points.add(Vector2(pos.dx, pos.dy));
      }
    }
    hitbox = PolygonHitbox(points);
  }

  @override
  void render(Canvas canvas) {
    double ox = 10, oy = 10; // 3D-effect

    Color color_side = Color(0xFF6D6D6D);
    Color color_top = Colors.white;

    Path path_side = path;
    Path path_top = path.shift(Offset(ox, oy));

    super.render(canvas);
    var paint = Paint()..strokeWidth = 4.0;

    paint.color = color_side;
    canvas.drawPath(path_side, paint);
    paint.color = color_top;
    canvas.drawPath(path_top, paint);
  }
}
