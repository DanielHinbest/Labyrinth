import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Window size for moving average
  final int windowSize = 10;

  // Lists to store recent values
  List<double> accelXValues = [];
  List<double> accelYValues = [];
  List<double> accelZValues = [];

  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();

    // Accelerometer events
    accelerometerEvents.listen(
      (AccelerometerEvent event) {
        setState(() {
          accelXValues.add(event.x);
          accelYValues.add(event.y);
          accelZValues.add(event.z);

          if (accelXValues.length > windowSize) accelXValues.removeAt(0);
          if (accelYValues.length > windowSize) accelYValues.removeAt(0);
          if (accelZValues.length > windowSize) accelZValues.removeAt(0);

          double avgAccelX =
              accelXValues.reduce((a, b) => a + b) / accelXValues.length;
          double avgAccelY =
              accelYValues.reduce((a, b) => a + b) / accelYValues.length;
          double avgAccelZ =
              accelZValues.reduce((a, b) => a + b) / accelZValues.length;

          // Determine the color based on the orientation
          backgroundColor = Color.fromARGB(
            255,
            (avgAccelX.abs() * 255 / 10).clamp(0, 255).toInt(),
            (avgAccelY.abs() * 255 / 10).clamp(0, 255).toInt(),
            (avgAccelZ.abs() * 255 / 10).clamp(0, 255).toInt(),
          );

          print('Filtered Accelerometer: ($avgAccelX, $avgAccelY, $avgAccelZ)');
        });
      },
      onError: (error) {
        // Handle error
      },
      cancelOnError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Demo'),
      ),
      body: Container(
        color: backgroundColor,
        child: const Center(
          child: Text('Listening to sensor events...'),
        ),
      ),
    );
  }
}
