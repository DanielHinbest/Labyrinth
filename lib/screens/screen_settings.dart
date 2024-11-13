import 'package:flutter/material.dart';
import 'package:labyrinth/components/gui_common.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Settings', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: AppBackground(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButton(
                      text: 'Music',
                      onIcon: Icons.music_note,
                      offIcon: Icons.music_off,
                      onPressed: () => {},
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      text: 'Language',
                      icon: Icons.language,
                      onPressed: () {},
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      text: 'Scores',
                      icon: Icons.star,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButton(
                      text: 'SFX',
                      onIcon: Icons.volume_up,
                      offIcon: Icons.volume_off,
                      onPressed: () => {},
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      text: 'Reset Progress',
                      icon: Icons.refresh,
                      onPressed: () {},
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      text: 'Credits',
                      icon: Icons.info_outline,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
