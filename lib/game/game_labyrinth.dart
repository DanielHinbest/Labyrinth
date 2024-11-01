import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:labyrinth/game/maze_data.dart';

class GameLabyrinth extends FlameGame {
  final MazeData? mazeData;

  GameLabyrinth({this.mazeData});

  @override
  Future<void> onLoad() async {
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