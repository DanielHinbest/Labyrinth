import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labyrinth/data/firebase_options.dart';
import 'package:labyrinth/data/settings.dart';
import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/util/logging.dart';

// TODO: Error checking? Also consider a splash screen or some other loading alternative
/// AppLoader is a utility class that initializes the app's environment and loads
/// necessary resources before running the app.
class AppLoader {
  static List<Level> levels = [];
  static bool firebaseInitialized = false;
  static bool systemChromeInitialized = false;
  static bool levelsLoaded = false;

  /// Bootstrap the app by initializing Firebase, SystemChrome, and loading levels.
  /// Then, run the app with the provided builder.
  ///
  /// `builder`: A function that returns the root widget of the app. e.g. `() => MyApp()`
  static Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
    WidgetsFlutterBinding.ensureInitialized();
    await initSystemChrome();
    await initFirebase();
    await loadLevels();
    await Settings.init();
    runApp(await builder());
  }

  /// Load levels from the assets directory.
  static Future<List<Level>> loadLevels() async {
    String manifestContent =
        await rootBundle.loadString('assets/levels/levels.json');
    List<dynamic> levelFiles = jsonDecode(manifestContent);

    appLogger.d('Loading levels: $levelFiles');

    for (String path in levelFiles) {
      appLogger.d('Loading level: $path');
      String content = await rootBundle.loadString(path);
      Map<String, dynamic> jsonData = jsonDecode(content);
      appLogger.d('Data for $path: $jsonData');
      levels.add(Level.fromJson(jsonData));
    }

    appLogger.d('Loaded ${levels.length} levels');
    levelsLoaded = true;
    return levels;
  }

  /// Initialize Firebase.
  static Future<void> initFirebase() async {
    appLogger.d('Initializing Firebase');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseInitialized = true;
  }

  /// Initialize SystemChrome.
  /// This sets the app to landscape mode and hides the system UI.
  static Future<void> initSystemChrome() async {
    appLogger.d('Initializing SystemChrome');
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations([
      // TODO: Remove one of these lines in favor of user selection via settings.
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    systemChromeInitialized = true;
  }
}
