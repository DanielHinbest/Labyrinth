import 'package:flutter/material.dart';

import 'package:labyrinth/util/theme/common.dart';

class DanielColors implements ThemeColors {
  static final instance = DanielColors();

  @override
  Color get particleColor => Colors.purple;
  @override
  Color get decorationColor => Colors.green;
  @override
  List<Color> get gradientColors => [
        Colors.purple,
        Colors.green,
        Colors.blue,
      ];

  @override
  ThemeData get theme => ThemeData.light().copyWith(
        pageTransitionsTheme: androidTransitionTheme,
        cardColor: Colors.purple,
        dialogBackgroundColor: Colors.green,
        disabledColor: Colors.blue,
        dividerColor: Colors.purple,
        focusColor: Colors.green,
        hintColor: Colors.blue,
        primaryColor: Colors.purple,
        shadowColor: Colors.green,
        unselectedWidgetColor: Colors.blue,
        textTheme: Typography.blackCupertino.copyWith(
          titleLarge: TextStyle(color: Colors.purple),
        ),
      );
}
