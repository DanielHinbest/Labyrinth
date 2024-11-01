import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/game_labyrinth.dart';

class ScreenGame extends StatelessWidget {
  const ScreenGame({super.key});

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
        game: GameLabyrinth(),
      ),
    );
  }
}