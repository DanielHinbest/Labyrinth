// ignore_for_file: constant_identifier_names
import 'dart:ui';

import 'package:labyrinth/util/theme/common.dart';
import 'package:labyrinth/util/theme/daniel_theme.dart';
import 'package:labyrinth/util/theme/dark_theme.dart';
import 'package:labyrinth/util/theme/light_theme.dart';

// This approach to app theming was inspired by a combination of peercoin_flutter and the linked stackoverflow post, though the approach is different
// https://github.com/peercoin/peercoin_flutter/blob/main/lib/tools/app_themes.dart
// https://stackoverflow.com/questions/75940017/how-to-create-3-different-color-themes-light-dark-and-custom

/// A class that holds the different themes that the app can have. The string representation of the theme is used to
/// determine which theme to use, since that is what is stored in shared preferences.
enum AppTheme {
  System,
  Light,
  Dark,
  Daniel,
}

/// Gets the theme colors from a string representation of the theme. If the theme is not recognized, the light theme is returned.
/// Access the theme data by calling `getThemeColors(theme).theme`
ThemeColors getThemeColors(String theme) {
  switch (theme) {
    case 'Light':
      return LightColors.instance;
    case 'Dark':
      return DarkColors.instance;
    case 'Daniel':
      return DanielColors.instance;
    case 'System':
      return PlatformDispatcher.instance.platformBrightness == Brightness.light
          ? LightColors.instance
          : DarkColors.instance;
    default:
      return LightColors.instance;
  }
}

/// Gets the app background particle color from a string representation of the theme
Color getParticleColor(String theme) {
  return getThemeColors(theme).particleColor;
}

/// Gets the app box decoration color from a string representation of the theme
Color getDecorationColor(String theme) {
  return getThemeColors(theme).decorationColor;
}

/// Gets the default gradient colors for buttons from a string representation of the theme
List<Color> getDefaultGradient(String theme) {
  return getThemeColors(theme).gradientColors;
}
