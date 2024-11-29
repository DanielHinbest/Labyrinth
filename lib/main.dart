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
import 'package:labyrinth/screens/screen_title.dart';
import 'package:labyrinth/util/language_manager.dart';

void main() async {
  AppLoader.bootstrap(() => const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SettingsProvider())
        ],
        builder: (context, _) {
          return Consumer<SettingsProvider>(builder: (context, settings, _) {
            return MaterialApp(
              title: 'Labyrinth',
              theme: ThemeData(
                //  [see this issue: https://github.com/flutter/flutter/issues/145894]
                // Because of how the default transitions work for MaterialPageRoutes the background animation froze when switching routes
                // Using cupertino transitions fixes this [https://stackoverflow.com/questions/50196913/how-to-change-navigation-animation-using-flutter]
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                }), // TODO: Proper theme data and handling
              ),
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
