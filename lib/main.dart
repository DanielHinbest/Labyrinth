/// File: main.dart
/// Author: Daniel Hinbest
/// Date: 2024-11-02
/// Description: This file contains the main entry point for the application, initializing Firebase and setting up the main widget.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:labyrinth/bootstrap.dart';
import 'package:labyrinth/data/providers/settings_provider.dart';
import 'package:labyrinth/data/providers/user_provider.dart';
import 'package:labyrinth/screens/screen_title.dart';
import 'package:labyrinth/util/language_manager.dart';
import 'package:labyrinth/util/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppLoader.bootstrap(() => const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SettingsProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        builder: (context, _) {
          return Consumer<SettingsProvider>(builder: (context, settings, _) {
            return MaterialApp(
              title: 'Labyrinth',
              theme: getThemeColors(settings.theme).theme,
              supportedLocales: LanguageManager.availableLocales.values.map(
                (e) {
                  var (locale, _) = e;
                  return locale;
                },
              ),
              locale: appLocale,
              localizationsDelegates: [
                LanguageManager.delegate,
                GlobalWidgetsLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
                ...GlobalCupertinoLocalizations.delegates,
              ],
              home: ScreenTitle(),
            );
          });
        });
  }
}
