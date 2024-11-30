import 'package:flutter/material.dart';

import 'package:labyrinth/util/theme/common.dart';

class DarkColors implements ThemeColors {
  static final instance = DarkColors();

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

  // Common Color Accessors
  @override
  Color get particleColor => white;
  @override
  Color get decorationColor => black;
  @override
  List<Color> get gradientColors => [
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

  @override
  ThemeData get theme => ThemeData.dark().copyWith(
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
        sliderTheme: SliderThemeData(valueIndicatorColor: DarkColors.darkBlue),
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
}
