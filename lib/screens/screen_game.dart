import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/game/level.dart';

import '../game/game_labyrinth.dart';

class ScreenGame extends StatelessWidget {
  final Level level;

  const ScreenGame({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placeholder Game Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GameWidget(
        game: GameLabyrinth(level.maze),
      ),
    );
  }
}
