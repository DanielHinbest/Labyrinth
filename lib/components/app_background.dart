import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatefulWidget {
  final Widget child;
  static AppBackground? _instance;

  const AppBackground._internal({required this.child});

  // Factory constructor to return the same instance
  factory AppBackground({required Widget child}) {
    if (_instance == null || _instance!.child != child) {
      _instance = AppBackground._internal(child: child);
    }
    return _instance!;
  }

  @override
  State<AppBackground> createState() => _AppBackground();
}

class _AppBackground extends State<AppBackground>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: RandomParticleBehaviour(
        options: ParticleOptions(
          baseColor: Colors.grey,
          spawnMaxSpeed: 30.0,
          spawnMinSpeed: 10.0,
          spawnMaxRadius: 20.0,
          spawnMinRadius: 5.0,
          particleCount: 50,
        ),
      ),
      vsync: this,
      child: widget.child,
    );
  }
}
