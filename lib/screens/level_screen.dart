/**
 * Group Members: Zachary Wayne, Ahmed, Daniel Hinbest, Raje Singh, Jugal Patel
 * File: levels_menu.dart
 * Description: Skeleton code for the Levels menu UI
 */

import 'package:flutter/material.dart';
import 'play_level_screen.dart';

class LevelScreen extends StatelessWidget
{
  final int totalLevels = 5; // Define the total number of levels here

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Level'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose a Level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Generate a list of level buttons
            for (int level = 1; level <= totalLevels; level++)
              ElevatedButton(
                onPressed: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayLevelScreen(levelNum: level),
                    ),
                  );
                },
                child: Text('Level $level'),
              ),
          ],
        ),
      ),
    );
  }
}