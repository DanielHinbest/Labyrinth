/**
 * Group Members: Zachary Wayne, Ahmed, Daniel Hinbest, Raje Singh, Jugal Patel
 * File: play_level_screen.dart
 * Description: Simplified UI for the Play Level Screen
 */

import 'package:flutter/material.dart';

class PlayLevelScreen extends StatelessWidget {
  final int levelNum;

  PlayLevelScreen({required this.levelNum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level $levelNum'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Level $levelNum',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Placeholder for game content',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Return to the previous screen (e.g., the main menu)
              },
              child: Text('Back to Menu'),
            ),
          ],
        ),
      ),
    );
  }
}

// ToDo: Create the actual game based on the level