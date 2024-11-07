import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'maze.dart';
import 'marble.dart';

class GameLabyrinth extends Forge2DGame {
  final Maze maze;

  GameLabyrinth(this.maze)
      : super(gravity: Vector2(0, 10), camera: CameraComponent());

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(Marble(Vector2(100, 100)));
  }
}
