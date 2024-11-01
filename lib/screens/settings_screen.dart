/**
 * Group Members: Zachary Wayne, Ahmed, Daniel Hinbest, Raje Singh, Jugal Patel
 * File: settings_screen.dart
 * Description: Enhanced Settings screen with features for Labyrinth game
 *
 * Resources used: https://api.flutter.dev/flutter/rendering/CrossAxisAlignment.html
 *
 */

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget
{
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double tiltSensitivity = 1.0;
  String theme = 'System';
  String difficulty = 'Easy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tilt Sensitivity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: tiltSensitivity,
              min: 0.5,
              max: 2.0,
              divisions: 6,
              label: tiltSensitivity.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  tiltSensitivity = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Theme Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: theme,
              items: <String>['System', 'Dark', 'Light'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  theme = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Starting Difficulty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: difficulty,
              items: <String>['Easy', 'Medium', 'Advanced', 'Expert'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  difficulty = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
