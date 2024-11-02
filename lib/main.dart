/// File: main.dart
/// Author: Daniel Hinbest
/// Date: 2024-11-02
/// Description: This file contains the main entry point for the application, initializing Firebase and setting up the main widget.

import 'package:flutter/material.dart';
import 'package:labyrinth/screens/screen_title.dart';
import 'package:labyrinth/tilt_test.dart';
import 'package:flutter/services.dart';
import 'data/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the preferred device orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft, // TODO: Remove one of these lines in favor of user selection via settings.
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
        print(snapshot.error);
        if (snapshot.hasError) {
          print('Error initializing Firebase');
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
            home: ScreenTitle(), // Main screen of the application
            /* home: const TiltTest(), */
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(), // Show a loading indicator while initializing Firebase
            ),
          ),
        );
      },
    );
  }
}