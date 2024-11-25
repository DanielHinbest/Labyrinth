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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Music setting clicked')),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      text: 'Language',
                      icon: Icons.language,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Language setting clicked')),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      text: 'Scores',
                      icon: Icons.star,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Scores setting clicked')),
                        );
                      },
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('SFX setting clicked')),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      text: 'Reset Progress',
                      icon: Icons.refresh,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Reset Progress setting clicked')),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      text: 'Credits',
                      icon: Icons.info_outline,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Credits setting clicked')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
