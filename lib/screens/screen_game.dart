import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/bootstrap.dart';
import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/data/score.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labyrinth/screens/screen_title.dart';

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
  late GameLabyrinth _gameLabyrinth;
  Alignment? pauseButtonAlignment;

  @override
  void initState() {
    super.initState();
    dbConnect = DBConnect();
    dbConnect.initDatabase();
    _gameLabyrinth = GameLabyrinth(widget.level.maze);
    _setupBackButtonHandler();
  }

  void _setupBackButtonHandler() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)?.addScopedWillPopCallback(() async {
        setState(() {
          isPaused = !isPaused;
        });
        return false;
      });
    });
  }

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

  // Method to open the pause menu when the pause button is tapped
  void pause() {
    setState(() {
      isPaused = true;
      _gameLabyrinth.pauseEngine();
    });
  }

  // Method to resume the game from the pause menu
  void resumeGame() {
    setState(() {
      isPaused = false;
      isPauseButtonVisible = false; // Hide the pause button after resuming
      _gameLabyrinth.resumeEngine();
    });
  }

  // TODO: Add logic to restart the game or level but embed it later if time permits.
  void restartGame() {
    // Implement restart functionality here if needed
  }

  // Method to go back to the main menu
  void mainMenu() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenTitle(),
      ),
    );
  }

  void endGame(int finalScore) async {
    Score score = Score(
      id: DateTime.now().millisecondsSinceEpoch,
      score: finalScore,
      date: DateTime.now().toIso8601String(),
    );
    await dbConnect.insertScore(score);

    await FirebaseFirestore.instance.collection('leaderboard').add({
      'name': 'Player', // Replace with actual player name
      'time': finalScore,
    });

    Navigator.pushNamed(context, '/game_over');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Game widget
          GameWidget(
            game: _gameLabyrinth,
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
                    // Keeping the TODO comment for restart functionality
                    ElevatedButton(
                      onPressed: () async {
                        await AppLoader.reloadLevels();
                        mainMenu();
                      },
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
