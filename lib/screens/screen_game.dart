import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/game/level.dart';

import '../game/game_labyrinth.dart';

class ScreenGame extends StatefulWidget {
  final Level level;

  const ScreenGame({super.key, required this.level});

  @override
  State<ScreenGame> createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame> {
  bool isPaused = false;
  bool isPauseButtonVisible = false;
  Alignment? pauseButtonAlignment;

  void showPauseButton(TapDownDetails details, Size screenSize) {
    setState(() {
      isPauseButtonVisible = true;

      // Determine the tapped corner
      final tapX = details.globalPosition.dx;
      final tapY = details.globalPosition.dy;

      if (tapX > screenSize.width / 2 && tapY < screenSize.height / 2) {
        pauseButtonAlignment = Alignment.topRight;
      } else if (tapX < screenSize.width / 2 && tapY < screenSize.height / 2) {
        pauseButtonAlignment = Alignment.topLeft;
      } else if (tapX < screenSize.width / 2 && tapY > screenSize.height / 2) {
        pauseButtonAlignment = Alignment.bottomLeft;
      } else {
        pauseButtonAlignment = Alignment.bottomRight;
      }
    });
  }

  void pause() {
    setState(() {
      isPaused = true;
    });
  }

  void resumeGame() {
    setState(() {
      isPaused = false;
      isPauseButtonVisible = false;
    });
  }

  void mainMenu() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Game widget
          GameWidget(
            game: GameLabyrinth(widget.level.maze),
          ),

          // Capture tap to show the pause button in a corner
          if (!isPauseButtonVisible)
            GestureDetector(
              onTapDown: (details) => showPauseButton(details, screenSize),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          // Pause button positioned in the selected corner
          if (isPauseButtonVisible && pauseButtonAlignment != null)
            Align(
              alignment: pauseButtonAlignment!,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: pause,
                  child: Icon(Icons.pause),
                ),
              ),
            ),

          // Pause menu
          if (isPaused)
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Game Paused',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: resumeGame,
                      child: Text('Resume'),
                    ),
                    ElevatedButton(
                      onPressed: mainMenu,
                      child: Text('Main Menu'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
