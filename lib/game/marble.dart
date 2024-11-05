import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'wall.dart';

class Marble extends PositionComponent with CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Wall) {
      /// TODO: Add collision logic
    }
  }
}
