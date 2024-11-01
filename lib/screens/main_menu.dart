/**
 * Group Members: Zachary Wayne, Ahmed, Daniel Hinbest, Raje Singh, Jugal Patel
 * File: main_menu.dart
 * Description: Skeleton code for the Main menu UI
 */

import 'package:flutter/material.dart';
import 'package:labyrinth/screens/level_screen.dart';
import 'package:labyrinth/screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labyrinth',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Labyrinth Main Menu'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LevelScreen(), // Navigate to LevelScreen on Play
                ),
              ),
              child: Text('Play'),
            ),
            SizedBox(height: 20), // Optional: spacing between buttons
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(), // Corrected to SettingsScreen
                ),
              ),
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
