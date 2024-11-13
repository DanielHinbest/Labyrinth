/// File: main.dart
/// Author: Daniel Hinbest
/// Date: 2024-11-02
/// Description: This file contains the main entry point for the application, initializing Firebase and setting up the main widget.
library;

import 'package:flutter/material.dart';
import 'package:labyrinth/bootstrap.dart';

import 'package:labyrinth/screens/screen_title.dart';

void main() {
  AppLoader.bootstrap(() => const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labyrinth',
      theme: ThemeData(
        primarySwatch: Colors.blue, // TODO: Proper theme data and handling
      ),
      home: ScreenTitle(),

      /// Main screen of the application
      /* home: const TiltTest(), */
    );
  }
}
