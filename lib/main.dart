/// File: main.dart
/// Author: Daniel Hinbest
/// Date: 2024-11-02
/// Description: This file contains the main entry point for the application, initializing Firebase and setting up the main widget.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:labyrinth/screens/screen_title.dart';
import 'package:labyrinth/data/firebase_options.dart';
import 'package:labyrinth/util/logging.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  /// Set the preferred device orientations
  SystemChrome.setPreferredOrientations([
    /// TODO: Remove one of these lines in favor of user selection via settings.
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        /// NOTE: widget gets built twice in debug mode
        appLogger.d('Initializing Firebase');
        if (snapshot.hasError) {
          appLogger.e('Error initializing Firebase', error: snapshot.error);
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Sensor Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: ScreenTitle(),

            /// Main screen of the application
            /* home: const TiltTest(), */
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),

              /// Show a loading indicator while initializing Firebase
            ),
          ),
        );
      },
    );
  }
}
