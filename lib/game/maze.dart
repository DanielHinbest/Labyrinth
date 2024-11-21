import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:labyrinth/game/wall.dart';

class Maze {
  final Vector2 start;
  final Vector2 goal;
  final List<Vector2> holes;
  final List<Wall> walls;

  Maze._(this.start, this.goal, this.holes, this.walls);

  factory Maze.fromJson(Map<String, dynamic> json) {
    final start = Vector2(
      json['start'][0].toDouble(),
      json['start'][1].toDouble(),
    );

    final goal = Vector2(
      json['goal'][0].toDouble(),
      json['goal'][1].toDouble(),
    );

    final holes = (json['holes'] as List)
        .map((hole) => Vector2(hole[0].toDouble(), hole[1].toDouble()))
        .toList();

    final walls = (json['walls'] as List).map((wallData) {
      return Wall.fromString(wallData);
    }).toList();

    return Maze._(start, goal, holes, walls);
  }
}
