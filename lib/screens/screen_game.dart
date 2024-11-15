import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/game/level.dart';

import '../game/game_labyrinth.dart';

class ScreenGame extends StatefulWidget
{
  final Level level;

  const ScreenGame({super.key, required this.level});

  @override
  State<ScreenGame> createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame>
{
  bool isPaused = false;
  bool isPauseButtonVisible = false;

  void showPauseButton()
  {
    setState(() {
      isPauseButtonVisible = true;
    });
  }

  void pause()
  {
    setState(()
    {
      isPaused = true;
    });
  }

  void resumeGame()
  {
    setState(() {
      isPaused = false;
      isPauseButtonVisible = false;
    });
  }

  // TODO: Add logic to restart the game or level but embed it later if time permits.
  void restartGame()
  {

  }

  void mainMenu()
  {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Stack(
        children: [
          // Game widget
          GameWidget(
            game: GameLabyrinth(widget.level.maze),
          ),

          if (!isPauseButtonVisible)
            GestureDetector(
              onTap: showPauseButton,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          if (isPauseButtonVisible)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: pause,
                child: Icon(Icons.pause),
              ),
            ),

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
                    // Keeping the TODO comment for restart functionality
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
