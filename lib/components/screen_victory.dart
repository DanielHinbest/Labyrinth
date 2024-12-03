import 'package:flutter/material.dart';

class VictoryScreen extends StatelessWidget
{
  final VoidCallback onNextLevel;
  final VoidCallback onMainMenu;

  const VictoryScreen({
    Key? key,
    required this.onNextLevel,
    required this.onMainMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.8), // Semi-transparent overlay
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You Win!',
              style: TextStyle(fontSize: 32, color: Colors.green),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNextLevel,
              child: Text('Next Level'),
            ),
            ElevatedButton(
              onPressed: onMainMenu,
              child: Text('Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
