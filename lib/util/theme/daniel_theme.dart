import 'package:flutter/material.dart';

import 'package:labyrinth/util/theme/common.dart';

class DanielColors implements ThemeColors {
  static final instance = DanielColors();

  @override
  Color get particleColor => Colors.amber;
  @override
  Color get decorationColor => Colors.lightGreenAccent;
  @override
  List<Color> get gradientColors => [Colors.yellow, Colors.pink, Colors.lime, Colors.cyan, Colors.orange];

  @override
  ThemeData get theme => ThemeData.light().copyWith(
        pageTransitionsTheme: androidTransitionTheme,
        cardColor: Colors.yellow,
        dialogBackgroundColor: Colors.pink,
        disabledColor: Colors.lime,
        dividerColor: Colors.orange,
        focusColor: Colors.cyan,
        hintColor: Colors.purple,
        primaryColor: Colors.lime,
        shadowColor: Colors.yellowAccent,
        unselectedWidgetColor: Colors.redAccent,
        textTheme: Typography.blackCupertino.copyWith(
          titleLarge: TextStyle(color: Colors.cyan),
        ),
      );
}