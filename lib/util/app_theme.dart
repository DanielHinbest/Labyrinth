// ignore_for_file: constant_identifier_names
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:labyrinth/util/logging.dart';

///
enum AppTheme {
  Light,
  Dark,
  System,
  Daniel,
}

//  [see this issue: https://github.com/flutter/flutter/issues/145894]
// Because of how the default transitions work for MaterialPageRoutes the background animation froze when switching routes
// Using cupertino transitions fixes this [https://stackoverflow.com/questions/50196913/how-to-change-navigation-animation-using-flutter]
final androidTransitionTheme = PageTransitionsTheme(builders: {
  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
});

extension AppThemeData on AppTheme {
  ThemeData get data {
    switch (this) {
      // Light Theme
      case AppTheme.Light:
        return ThemeData.light().copyWith(
          pageTransitionsTheme: androidTransitionTheme,
          cardColor: LightColors.white,
          dialogBackgroundColor: LightColors.white,
          disabledColor: LightColors.grey, // was light green
          dividerColor: LightColors.lightGrey, // was dark green
          focusColor: LightColors.lightGrey, // was green
          hintColor: LightColors.grey,
          primaryColor: LightColors.lightGrey, // was green
          shadowColor: LightColors.charcoalBlack, // was light green
          unselectedWidgetColor: LightColors.grey,
          textTheme: Typography.blackCupertino.copyWith(
            titleLarge: TextStyle(color: LightColors.black),
            headlineSmall: TextStyle(color: LightColors.black),
            headlineMedium: TextStyle(color: LightColors.black),
            displaySmall: TextStyle(color: LightColors.black),
            displayMedium: TextStyle(color: LightColors.black),
            displayLarge: TextStyle(color: LightColors.black),
            titleMedium: TextStyle(color: LightColors.black),
            titleSmall: TextStyle(color: LightColors.black),
            bodyLarge: TextStyle(color: LightColors.black),
            bodyMedium: TextStyle(color: LightColors.black),
            labelLarge: TextStyle(
              letterSpacing: 1.4,
              fontSize: 16,
              color: LightColors.black,
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: LightColors.black,
            unselectedLabelColor: LightColors.grey,
            indicatorColor: LightColors.black,
            dividerColor: LightColors.grey,
          ),
          listTileTheme: ListTileThemeData(
            iconColor: LightColors.black,
            textColor: LightColors.black,
          ),
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: LightColors.lightGrey, // was green
            contentTextStyle: TextStyle(color: LightColors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: LightColors.black, // was green
              backgroundColor: LightColors.grey, // was green
              iconColor: LightColors.grey,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: LightColors.black,
            ),
          ),
          sliderTheme: SliderThemeData(
            valueIndicatorTextStyle: TextStyle(
              color: LightColors.lightGrey, // was green
              fontWeight: FontWeight.bold,
            ),
          ),
          switchTheme: SwitchThemeData(
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return LightColors.black;
              }
              return LightColors.grey;
            }),
            trackColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return LightColors.grey;
              }
              return LightColors.white;
            }),
            trackOutlineColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return LightColors.white;
              }
              return LightColors.grey;
            }),
          ),
          // checkboxTheme: CheckboxThemeData(
          //   overlayColor: WidgetStateProperty.all(LightColors.mutedGreen),
          // ),
          colorScheme: ColorScheme(
            primary: LightColors.lightGrey, // was green
            primaryContainer: LightColors.coolGrey, // was dark green
            secondary: LightColors.grey,
            secondaryContainer: LightColors.lightGrey,
            surface: LightColors.white,
            error: LightColors.red,
            onPrimary: LightColors.white,
            onSecondary: LightColors.blackGreen,
            onSurface: LightColors.black,
            onError: LightColors.red,
            brightness: Brightness.light,
            tertiary: LightColors.white,
          )
              .copyWith(surface: LightColors.white)
              .copyWith(error: LightColors.red),
        );

      // Dark Theme
      case AppTheme.Dark:
        return ThemeData.dark().copyWith(
          pageTransitionsTheme: androidTransitionTheme,
          cardColor: DarkColors.darkBlue, // was green

          /// was green
          dialogBackgroundColor: DarkColors.darkBlue, // was green
          disabledColor: DarkColors.slateGray, // was darkBlue
          dividerColor: DarkColors.darkPurple, // was light green
          focusColor: DarkColors.black,
          hintColor: DarkColors.white,
          primaryColor: DarkColors.black,
          iconTheme: IconThemeData(color: DarkColors.white),
          scaffoldBackgroundColor: DarkColors.black,
          shadowColor: DarkColors.darkBlue,
          snackBarTheme: SnackBarThemeData(
            backgroundColor: DarkColors.darkBlue,
            actionTextColor: DarkColors.white,
            contentTextStyle: TextStyle(color: DarkColors.white),
          ),
          sliderTheme:
              SliderThemeData(valueIndicatorColor: DarkColors.darkBlue),
          unselectedWidgetColor: DarkColors.white,
          radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.all(DarkColors.white),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: DarkColors.white,
            unselectedLabelColor: DarkColors.grey,
            indicatorColor: DarkColors.white,
            dividerColor: DarkColors.grey,
          ),
          listTileTheme: ListTileThemeData(
            iconColor: DarkColors.white,
            textColor: DarkColors.white,
          ),
          textTheme: Typography.whiteCupertino.copyWith(
            titleLarge: TextStyle(color: DarkColors.white),
            headlineSmall: TextStyle(color: DarkColors.white),
            headlineMedium: TextStyle(color: DarkColors.white),
            displaySmall: TextStyle(color: DarkColors.white),
            displayMedium: TextStyle(color: DarkColors.white),
            displayLarge: TextStyle(color: DarkColors.white),
            titleMedium: TextStyle(color: DarkColors.white),
            titleSmall: TextStyle(color: DarkColors.white),
            bodyLarge: TextStyle(color: DarkColors.black),
            bodyMedium: TextStyle(color: DarkColors.white),
            labelLarge: TextStyle(
              letterSpacing: 1.4,
              fontSize: 16,
              color: DarkColors.white,
            ),
            labelMedium: TextStyle(color: DarkColors.white),
            labelSmall: TextStyle(color: DarkColors.white),
          ),
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // cardTheme: CardTheme(
          //   elevation: 2,
          //   color: DarkColors.green,
          //   margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
          //   shape: RoundedRectangleBorder(
          //     //to set border radius to button
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          // ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: DarkColors.white,
              backgroundColor: DarkColors.darkPurple,
              iconColor: DarkColors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: DarkColors.white,
              // backgroundColor: DarkColors.darkBlue,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: DarkColors.black),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: DarkColors.white),
            ),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: DarkColors.black,
          ),
          switchTheme: SwitchThemeData(
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return DarkColors.white;
              }
              return DarkColors.grey;
            }),
            trackColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return DarkColors.grey;
              }
              return DarkColors.white;
            }),
            trackOutlineColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return DarkColors.black;
              }
              return DarkColors.white;
            }),
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: WidgetStateProperty.all(DarkColors.white),
          ),
          // expansionTileTheme: ExpansionTileThemeData(
          //   iconColor: DarkColors.white,
          // ),
          colorScheme: ColorScheme(
            primary: DarkColors.darkBlue, // was green
            primaryContainer: DarkColors.white,
            secondary: DarkColors.white,
            secondaryContainer: DarkColors.grey,
            surface: DarkColors.darkBlue, // was green
            error: DarkColors.red,
            onPrimary: DarkColors.darkBlue, // was green
            onSecondary: DarkColors.darkBlue, // was green
            onSurface: DarkColors.black,
            onError: DarkColors.red,
            brightness: Brightness.dark,
            tertiary: DarkColors.white,
          ),
        );
      // Daniel Theme (wacky mode)
      case AppTheme.Daniel:
        return ThemeData.light()
            .copyWith(pageTransitionsTheme: androidTransitionTheme);
      // System Theme (set either light or dark)
      case AppTheme.System:
        return PlatformDispatcher.instance.platformBrightness ==
                Brightness.light
            ? AppTheme.Light.data
            : AppTheme.Dark.data;
      default:
        return ThemeData.fallback().copyWith(
          pageTransitionsTheme: androidTransitionTheme,
        );
    }
  }
}

// This approach is from peercoin_flutter (entire approach is different but this abstract class idea from them)
// https://github.com/peercoin/peercoin_flutter/blob/main/lib/tools/app_themes.dart
abstract class LightColors {
  static Color get black => const Color(0xFF000000);
  static Color get blackGreen => const Color(0xFF31493C);
  // static Color get darkGreen => const Color(0xFF2A7A3A);
  // static Color get green => const Color(0xff3cb054);
  // static Color get lightGreen => const Color(0xffB3E5BD);
  static Color get grey => const Color(0xFF717C89);
  static Color get lightGrey => const Color(0x55717C89);
  static Color get white => const Color(0xFFFAFAFA);
  static Color get red => const Color(0xFFF8333C);
  static Color get yellow => const Color(0xFFFFBF46);
  // Primary Colors
  static Color get softBlue => Color(0xFF5B9BD5); // Soft Blue
  static Color get mutedGreen => Color(0xFF8BC34A); // Muted Green
  static Color get lightCoral => Color(0xFFF28B82); // Light Coral

// Secondary Colors
  static Color get lightTaupe => Color(0xFFE0DCD0); // Light Taupe
  static Color get coolGrey => Color(0xFFB0BEC5); // Cool Gray

// Typography and Icons
  static Color get charcoalBlack => Color(0xFF333333); // Charcoal Black
  static Color get paleGray => Color(0xFFF5F5F5); // Pale Gray

// Highlight Variations
  static Color get goldenYellow => Color(0xFFFBC02D); // Golden Yellow
  static Color get skyBlue => Color(0xFF81D4FA); // Sky Blue

  static Color get particleColor => black;
  static Color get decorationColor => white;
  static List<Color> get gradientColors => [
        Colors.grey[700]!,
        Colors.grey[800]!,
        Colors.grey[900]!,
        Colors.black,
      ];
}

abstract class DarkColors {
  static Color get black => const Color(0xFF0D1821);
  // static Color get darkGreen => const Color(0xFF2A7A3A);
  // static Color get green => const Color(0xFF2D936C);
  // static Color get lightGreen => const Color(0xffB3E5BD);
  static Color get darkBlue => const Color(0xFF234058);
  static Color get grey => const Color(0xFF717C89);
  static Color get white => const Color(0xFFFAFAFA);
  static Color get red => const Color(0xFFA8201A);

  // Primary Colors
  static Color get teal => Color(0xFF26A69A); // Teal
  static Color get darkPurple => Color(0xFF311B92); // Rich Purple
  static Color get deepRed => Color(0xFFEF5350); // Deep Red

// Secondary Colors
  static Color get slateGray => Color(0xFF37474F); // Slate Gray
  static Color get deepBlueGray => Color(0xFF455A64); // Deep Blue-Gray

// Typography and Icons
  static Color get offWhite => Color(0xFFE0E0E0); // Off-White
  static Color get warmGray => Color(0xFF9E9E9E); // Warm Gray

// Highlight Variations
  static Color get amber => Color(0xFFFFC107); // Amber
  static Color get cyan => Color(0xFF00BCD4); // Cyan

  static Color get particleColor => white;
  static Color get decorationColor => black;
  static List<Color> get gradientColors => [
        Color(0xFF101010), // Deep black with a hint of softness
        Color(0xFF121212), // Slightly lighter shade of black
        Color(0xFF131313), // Slightly lighter shade of black
        Color(0xFF141414), // Slightly lighter shade of black
        Color(0xFF151515), // Slightly lighter shade of black
        Color(0xFF161616), // Slightly lighter shade of black
        Color(0xFF171717), // Slightly lighter shade of black
        Color(0xFF181818), // Slightly lighter shade of black
        Color(0xFF191919), // Slightly lighter shade of black
      ];
}

abstract class DanielColors {}

AppTheme getAppTheme(String theme) {
  appLogger.d('Getting theme: $theme');
  switch (theme) {
    case 'Light':
      return AppTheme.Light;
    case 'Dark':
      return AppTheme.Dark;
    case 'Daniel':
      return AppTheme.Daniel;
    default:
      return AppTheme.System;
  }
}

// Surely more efficient way of doing these
Color getParticleColor(String theme) {
  // Change particle color based on AppTheme
  switch (theme) {
    case 'Light':
      return LightColors.particleColor;
    case 'Dark':
      return DarkColors.particleColor;
    case 'System':
      return PlatformDispatcher.instance.platformBrightness == Brightness.light
          ? LightColors.particleColor
          : DarkColors.particleColor;
    default:
      return LightColors.particleColor;
  }
}

Color getDecorationColor(String theme) {
  // Change decoration color based on AppTheme
  switch (theme) {
    case 'Light':
      return LightColors.decorationColor;
    case 'Dark':
      return DarkColors.decorationColor;
    case 'System':
      return PlatformDispatcher.instance.platformBrightness == Brightness.light
          ? LightColors.decorationColor
          : DarkColors.decorationColor;
    default:
      return LightColors.decorationColor;
  }
}

List<Color> getDefaultGradient(String theme) {
  // Change gradient color based on AppTheme
  switch (theme) {
    case 'Light':
      return LightColors.gradientColors;
    case 'Dark':
      return DarkColors.gradientColors;
    case 'System':
      return PlatformDispatcher.instance.platformBrightness == Brightness.light
          ? LightColors.gradientColors
          : DarkColors.gradientColors;
    default:
      return LightColors.gradientColors;
  }
}
