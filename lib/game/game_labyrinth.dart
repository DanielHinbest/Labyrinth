import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:labyrinth/game/maze.dart';
import 'dart:ui';

class GameLabyrinth extends FlameGame {
  final Maze maze;

  GameLabyrinth(this.maze);

  @override
  Future<void> onLoad() async {
    maze.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
