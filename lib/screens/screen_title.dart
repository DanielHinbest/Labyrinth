import 'package:flutter/material.dart';
import 'package:labyrinth/bootstrap.dart';
import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/components/user_profile_button.dart';
import 'package:labyrinth/screens/screen_levels.dart';
import 'package:labyrinth/screens/screen_settings.dart';
import 'package:labyrinth/screens/screen_signup.dart';
import 'package:labyrinth/util/language_manager.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: AppBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LanguageManager.instance.translate('app_title'),
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
                text: LanguageManager.instance.translate('screen_title_levels'),
                icon: Icons.play_arrow,
                onPressed: () async {
                  await AppLoader.reloadLevels();
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
                text:
                    LanguageManager.instance.translate('screen_title_options'),
                icon: Icons.settings,
                onPressed: () {
                  showSettingsOverlay(context);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: UserProfileButton(
        onPressed: () {
          showSignUpOverlay(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
