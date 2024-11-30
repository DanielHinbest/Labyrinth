import 'package:flutter/material.dart';

//  [see this issue: https://github.com/flutter/flutter/issues/145894]
// Because of how the default transitions work for MaterialPageRoutes the background animation froze when switching routes
// Using cupertino transitions fixes this [https://stackoverflow.com/questions/50196913/how-to-change-navigation-animation-using-flutter]
final androidTransitionTheme = PageTransitionsTheme(builders: {
  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
});

/// Holds colors that are present in all themes, but do not exist on ThemeData
abstract class ThemeColors {
  /// The color of the particles in the background
  Color get particleColor;

  /// The color for box decorations
  Color get decorationColor;

  /// The default gradient colors for the `GradientButton` class
  List<Color> get gradientColors;

  /// The theme data for the theme
  ThemeData get theme;
}
