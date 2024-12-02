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

  GameLabyrinth(this.maze) : super(gravity: Vector2(0, 50));

  Marble? marble;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print('World type: ${world.runtimeType}');

    Vector2 marbleSpawnPosition = Vector2(240, 0);

    marble = Marble(marbleSpawnPosition);
    await world.add(marble!);
    await Future.wait(maze.walls.map((wall) async => await world.add(wall)));
    for (final hole in maze.holes) {
      holes.add(hole);
      await world.add(hole);
    }

    // Set initial camera position and zoom
    camera.viewfinder.zoom = 1.8;
    camera.moveTo(Vector2(230, 100));
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
