import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:labyrinth/util/app_theme.dart';
import 'package:provider/provider.dart';

import 'package:labyrinth/data/providers/settings_provider.dart';

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
    final settings = context.watch<SettingsProvider>();
    return AnimatedBackground(
      behaviour: RandomParticleBehaviour(
        options: ParticleOptions(
          // Change baseColor based on AppTheme
          baseColor: getParticleColor(settings.theme),
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
