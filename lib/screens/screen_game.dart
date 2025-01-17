import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/bootstrap.dart';
import 'package:labyrinth/components/victory_overlay.dart';
import 'package:labyrinth/data/providers/settings_provider.dart';
import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/data/score.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labyrinth/screens/screen_title.dart';
import 'package:labyrinth/util/audio_service.dart';
import 'package:labyrinth/util/language_manager.dart';
import 'package:labyrinth/util/logging.dart';
import 'package:provider/provider.dart';

import '../data/providers/user_provider.dart';
import '../game/game_labyrinth.dart';
import 'package:labyrinth/data/db_connect.dart';

import '../game/maze.dart';

class ScreenGame extends StatefulWidget {
  final Level level;

  const ScreenGame({super.key, required this.level});

  @override
  State<ScreenGame> createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame> {
  bool isPaused = false;
  bool isPauseButtonVisible = false; // Initially hidden
  bool showVictoryOverlay = false;
  late DBConnect dbConnect;
  late GameLabyrinth _gameLabyrinth;
  Alignment? pauseButtonAlignment;
  Timer? _timer;
  int _elapsedSeconds = 0;

  Future<void> _startGameMusic() async {
    if (context.read<SettingsProvider>().musicOn) {
      appLogger.d('Stopping menu music, starting game music');
      await AudioService.instance.stopBackgroundMusic(); // Stop menu music
      await AudioService.instance
          .playBackgroundMusic(AudioService.gameBgm); // Start game music
      appLogger.d('Game music started');
    }
  }

  Future<void> _stopGameMusic() async {
    if (context.read<SettingsProvider>().musicOn) {
      appLogger.d('Stopping game music, starting menu music');
      await AudioService.instance.stopBackgroundMusic(); // Stop game music
      await AudioService.instance
          .playBackgroundMusic(AudioService.menuBgm); // Start menu music
      appLogger.d('Menu music started');
    }
  }

  @override
  void initState() {
    super.initState();
    dbConnect = DBConnect();
    dbConnect.initDatabase();
    _gameLabyrinth = GameLabyrinth(widget.level.maze, _stopTimer);
    _setupBackButtonHandler();
    // Start game music and stop menu music
    _startGameMusic();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    endGame(_elapsedSeconds);
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
  Future<void> mainMenu() async {
    await _stopGameMusic();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenTitle(),
      ),
    );
  }

  void endGame(int finalScore) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String level = widget.level.name;
    final String date =
        DateTime.now().toIso8601String().split('T').first; // Only the date part
    final String playerName = userProvider.currentUser.username;

    // Insert the score into SQLite
    await dbConnect.insertScore(finalScore, level, date);
    // print('Inserted score into SQLite: $finalScore for level: $level');

    // Add the score to Firestore
    try {
      await FirebaseFirestore.instance.collection('leaderboard').add({
        'name': playerName,
        'time': finalScore,
        'level': level,
        'date': date,
      });
      // print('Added score to Firebase: $finalScore for player: $playerName');
    } catch (e) {
      // print('Error adding score to Firebase: $e');
    }

    setState(() {
      showVictoryOverlay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final showTimer = context.read<SettingsProvider>().timerVisible;

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
                      LanguageManager.instance
                          .translate('screen_game_pause_title'),
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: resumeGame,
                      child: Text(LanguageManager.instance
                          .translate('screen_game_pause_resume')),
                    ),
                    // Keeping the TODO comment for restart functionality
                    ElevatedButton(
                      onPressed: () async {
                        await AppLoader.reloadLevels();
                        await mainMenu();
                      },
                      child: Text(LanguageManager.instance
                          .translate('screen_game_pause_main_menu')),
                    ),
                  ],
                ),
              ),
            ),

          if (showVictoryOverlay)
            VictoryOverlay(
              onNextLevel: () async {
                await AppLoader.reloadLevels();
                mainMenu(); // go back to main menu for now, some issues with changing levels in this context
              },
              onMainMenu: mainMenu,
            ),

          // Timer display
          if (showTimer)
            Positioned(
              top: 20,
              right: 20,
              child: Text(
                LanguageManager.instance.translate(
                    'screen_game_timer', {'time': '$_elapsedSeconds s'}),
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
