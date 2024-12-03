import 'package:flutter/material.dart';
import 'package:labyrinth/util/language_manager.dart';

class VictoryOverlay extends StatelessWidget {
  final VoidCallback onNextLevel;
  final VoidCallback onMainMenu;

  const VictoryOverlay({
    super.key,
    required this.onNextLevel,
    required this.onMainMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.8), // Semi-transparent overlay
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LanguageManager.instance.translate('screen_game_victory_title'),
              style: TextStyle(fontSize: 32, color: Colors.green),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNextLevel,
              child: Text(LanguageManager.instance
                  .translate('screen_game_victory_next_level')),
            ),
            ElevatedButton(
              onPressed: onMainMenu,
              child: Text(LanguageManager.instance
                  .translate('screen_game_victory_main_menu')),
            ),
          ],
        ),
      ),
    );
  }
}
