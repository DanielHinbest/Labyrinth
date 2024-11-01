import 'package:flutter/material.dart';
import 'package:labyrinth/screens/screen_title.dart';
import 'package:labyrinth/tilt_test.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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

