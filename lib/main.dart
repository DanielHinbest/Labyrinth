import 'package:flutter/material.dart';
import 'package:labyrinth/screens/screen_title.dart';
import 'package:labyrinth/tilt_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenTitle(),
      /* home: const TiltTest(), */
    );
  }
}

