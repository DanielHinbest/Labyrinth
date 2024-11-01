import 'package:flutter/material.dart';
import 'screen_game.dart';

class ScreenLevels extends StatelessWidget {
  const ScreenLevels({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placeholder Level Selection Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose a Level'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenGame(),
                  ),
                );
              },
              child: Text('Level A'),
            ),
          ],
        ),
      ),
    );
  }
}
