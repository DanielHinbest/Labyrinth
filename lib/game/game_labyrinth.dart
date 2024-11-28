import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'maze.dart';
import 'marble.dart';
import 'hole.dart';

class GameLabyrinth extends Forge2DGame {
  final Maze maze;
  final List<Hole> holes = [];

  GameLabyrinth(this.maze)
      : super(gravity: Vector2(0, 50), camera: CameraComponent());

  Marble? marble;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print('World type: ${world.runtimeType}');
    marble = Marble(Vector2(0, -30));
    await world.add(marble!);
    await Future.wait(maze.walls.map((wall) async => await world.add(wall)));
    for (final hole in maze.holes) {
      holes.add(hole);
      await world.add(hole);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    checkCollisions();
  }

  void checkCollisions() {
    if (marble == null || marble!.body == null) return;

    for (final hole in holes) {
      if (hole.body == null) continue;
      if (isColliding(marble!, hole)) {
        print('Marble entered the hole');
        marble!.shrinkAndDisappear();
      }
    }
  }

  bool isColliding(Marble marble, Hole hole) {
    final marblePosition = marble.body?.position;
    final holePosition = hole.body?.position;
    if (marblePosition == null || holePosition == null) return false;
    final distance = marblePosition.distanceTo(holePosition);
    return distance < (marble.shape.radius + hole.radius);
  }
}
