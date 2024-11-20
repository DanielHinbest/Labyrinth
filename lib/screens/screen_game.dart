import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/data/score.dart';

import '../game/game_labyrinth.dart';
import 'package:labyrinth/data/db_connect.dart';

class ScreenGame extends StatefulWidget {
  final Level level;

  const ScreenGame({super.key, required this.level});

  @override
  State<ScreenGame> createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame> {
  bool isPaused = false;
  bool isPauseButtonVisible = false; // Initially hidden
  late DBConnect dbConnect;

  @override
  void initState() {
    super.initState();
    dbConnect = DBConnect();
    dbConnect.initDatabase();
  }

  // Method to show the pause button on the first tap
  void showPauseButton() {
    setState(() {
      isPauseButtonVisible = true;
    });
  }

  // Method to open the pause menu when the pause button is tapped
  void pause() {
    setState(() {
      isPaused = true;
    });
  }

  // Method to resume the game from the pause menu
  void resumeGame() {
    setState(() {
      isPaused = false;
      isPauseButtonVisible = false; // Hide the pause button after resuming
    });
  }

  // TODO: Add logic to restart the game or level but embed it later if time permits.
  void restartGame() {
    // Implement restart functionality here if needed
  }

  // Method to go back to the main menu
  void mainMenu() {
    Navigator.pop(context);
  }

  void endGame(int finalScore) async {
    Score score = Score(
      id: DateTime.now().millisecondsSinceEpoch,
      score: finalScore,
      date: DateTime.now().toIso8601String(),
    );
    await dbConnect.insertScore(score);
    Navigator.pushNamed(context, '/game_over');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Game widget
          GameWidget(
            game: GameLabyrinth(widget.level.maze),
          ),
          // First tap anywhere to show the pause button
          if (!isPauseButtonVisible)
            GestureDetector(
              onTap: showPauseButton,
              child: Container(
                color: Colors.transparent, // Invisible area to detect the first tap
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          // Pause button positioned in the bottom-right corner, visible after the first tap
          if (isPauseButtonVisible)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: pause,
                child: Icon(Icons.pause),
              ),
            ),
          // Pause menu overlay when the game is paused
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
