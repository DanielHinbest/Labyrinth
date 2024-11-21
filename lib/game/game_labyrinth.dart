import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'maze.dart';
import 'marble.dart';

class GameLabyrinth extends Forge2DGame {
  final Maze maze;

  GameLabyrinth(this.maze)
      : super(gravity: Vector2(0, 50), camera: CameraComponent());

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    world.add(Marble(Vector2(0, -30)));
    world.addAll(maze.walls);
  }
}
