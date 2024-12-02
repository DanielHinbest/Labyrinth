import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:labyrinth/game/wall.dart';
import 'package:labyrinth/game/hole.dart';

class Maze {
  final Vector2 start;
  final Vector2 goal;
  final List<Hole> holes;
  final List<Wall> walls;

  Maze._(this.start, this.holes, this.walls, this.goal);

  factory Maze.fromJson(Map<String, dynamic> json) {
    final start = Vector2(
      json['start'][0].toDouble(),
      json['start'][1].toDouble(),
    );
    final goal = Vector2(
      json['goal'][0].toDouble(),
      json['goal'][1].toDouble(),
    );

    final holes = (json['holes'] as List).map((holeData) {
      return Hole(
        center: Vector2(holeData[0].toDouble(), holeData[1].toDouble()),
        radius: 5.0,
      );
    }).toList();

    final walls = (json['walls'] as List).map((wallData) {
      return Wall.fromString(wallData);
    }).toList();

    return Maze._(start, holes, walls, goal);
  }
}
