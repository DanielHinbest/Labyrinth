import 'package:flutter/material.dart';
import 'package:labyrinth/screens/screen_levels.dart';
import 'package:labyrinth/screens/screen_settings.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Labyrinth Main Menu'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenLevels(),
                ),
              ),
              child: Text('Play'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenSettings(),
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
