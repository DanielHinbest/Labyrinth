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
<<<<<<< HEAD
  }

  void loadHitbox() {
    /// Test if the hitbox has already been loaded, no need to load it again
=======
  }

  @override
  Future<void> onLoad() async {
    loadHitbox();
    if (hitbox != null) {
      add(hitbox!);
    }
  }

  void loadHitbox() {
>>>>>>> main
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
    super.render(canvas);

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4.0;
    canvas.drawPath(path, paint);
  }
}
