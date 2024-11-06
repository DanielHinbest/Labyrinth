import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'maze.dart';
import 'marble.dart';

class GameLabyrinth extends FlameGame {
  final Maze maze;
  final Marble marble = Marble();

  GameLabyrinth(this.maze);

  @override
  Future<void> onLoad() async {
<<<<<<< HEAD
    maze.onLoad();
=======
    await maze.onLoad();
    await marble.onLoad();
>>>>>>> main
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    maze.render(canvas);
    marble.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    marble.update(dt);
  }
}
