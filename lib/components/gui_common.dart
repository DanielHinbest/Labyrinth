import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/components/background_game.dart';

Stack backgroundStack(Widget child) {
  return Stack(children: [GameWidget(game: BackgroundGame()), child]);
}
