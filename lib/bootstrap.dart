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
class AppLoader {
  static List<Level> levels = [];
  static bool firebaseInitialized = false;
  static bool systemChromeInitialized = false;
  static bool levelsLoaded = false;

  static Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
    WidgetsFlutterBinding.ensureInitialized();
    await initSystemChrome();
    await initFirebase();
    await loadLevels();
    await Settings.init();
    runApp(await builder());
  }

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

  static Future<void> initFirebase() async {
    appLogger.d('Initializing Firebase');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseInitialized = true;
  }

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

  static Future<void> reloadLevels() async {
    levels.clear();
    await loadLevels();
  }
}
