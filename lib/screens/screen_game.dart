import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ScreenGame extends StatefulWidget {
  final Level level;

  const ScreenGame({super.key, required this.level});

  @override
  State<ScreenGame> createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame> {
  bool isPaused = false;
  bool isPauseButtonVisible = false;
  bool hasWon = false; // Tracks whether the user has won
  late GameLabyrinth _gameLabyrinth;
  Alignment? pauseButtonAlignment;

  @override
  void initState() {
    super.initState();
    _gameLabyrinth = GameLabyrinth(
      widget.level.maze,
      onVictory: handleVictory, // Pass the victory callback
    );
  }

  void handleVictory() {
    setState(() {
      hasWon = true;
      _gameLabyrinth.pauseEngine(); // Pause the game
    });
  }

  void showPauseButton(TapDownDetails details, Size screenSize) {
    setState(() {
      isPauseButtonVisible = true;

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
      _gameLabyrinth.pauseEngine();
    });
  }

  void resumeGame() {
    setState(() {
      isPaused = false;
      isPauseButtonVisible = false;
      _gameLabyrinth.resumeEngine();
    });
  }

  void restartGame() {
    setState(() {
      hasWon = false;
      isPaused = false;
      _gameLabyrinth.resetGame(); // Reset the game
    });
  }

  void mainMenu() {
    Navigator.pop(context); // Go back to the main menu
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          isPaused = !isPaused;
        });
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: _gameLabyrinth),
            if (!isPauseButtonVisible)
              GestureDetector(
                onTapDown: (details) => showPauseButton(details, screenSize),
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
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
            if (hasWon)
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Victory!',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: restartGame,
                        child: Text('Restart'),
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
      ),
    );
  }
}

// Game logic class with victory condition
class GameLabyrinth extends FlameGame {
  final VoidCallback onVictory;
  final Maze maze;

  GameLabyrinth(this.maze, {required this.onVictory});

  bool _hasReachedGoal = false; // Tracks if the player has reached the goal

  void checkVictoryCondition() {
    // Example victory condition: Player reaches the goal in the maze
    if (!_hasReachedGoal && maze.isPlayerAtGoal()) {
      _hasReachedGoal = true; // Prevent multiple triggers
      onVictory(); // Trigger the victory callback
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    checkVictoryCondition();
  }

  void resetGame() {
    // Logic to reset the game state
    _hasReachedGoal = false; // Reset the victory state
    print("Game has been reset");
  }
}

// Maze class with a goal-checking method
class Maze {
  Maze.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError("Maze data is null");
    }
    // Parse maze fields here
  }

  bool isPlayerAtGoal() {
    // Replace this with your actual logic to check if the player is at the goal
    // For example, check the player's position against the goal position
    return true; // Placeholder: Always return true for demonstration
  }
}

// Level class
class Level {
  final Maze maze;

  Level.fromJson(Map<String, dynamic>? json)
      : maze = Maze.fromJson(json?['maze']) {
    if (json == null) {
      throw ArgumentError("Level data is null");
    }
  }
}
