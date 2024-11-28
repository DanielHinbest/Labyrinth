import 'package:flutter/material.dart';

import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/screens/screen_levels.dart';
import 'package:labyrinth/screens/screen_settings.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: AppBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LABYRINTH',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4.0,
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                GradientButton(
                  text: 'LEVELS',
                  icon: Icons.play_arrow,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenLevels(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                GradientButton(
                  text: 'OPTIONS',
                  icon: Icons.settings,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ScreenSettings(),
                    //   ),
                    // );
                    showSettingsOverlay(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
