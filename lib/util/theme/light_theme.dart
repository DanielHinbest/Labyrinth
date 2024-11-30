import 'package:flutter/material.dart';

import 'package:labyrinth/util/theme/common.dart';

class LightColors implements ThemeColors {
  static final instance = LightColors();
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

  // Common Color Accessors
  @override
  Color get particleColor => black;
  @override
  Color get decorationColor => white;
  @override
  List<Color> get gradientColors => [
        Colors.grey[700]!,
        Colors.grey[800]!,
        Colors.grey[900]!,
        Colors.black,
      ];

  @override
  ThemeData get theme => ThemeData.light().copyWith(
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
        ).copyWith(surface: LightColors.white).copyWith(error: LightColors.red),
      );
}
