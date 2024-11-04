import 'package:flame/components.dart';
import 'package:labyrinth/game/wall.dart';

class Maze {
  final Vector2 start;
  final Vector2 goal;
  final List<Vector2> holes;
  final List<Wall> walls;

  Maze._(this.start, this.goal, this.holes, this.walls);

  factory Maze.fromJson(Map<String, dynamic> json) {
    // Parse start and goal as Vector2
    final start = Vector2(
      json['start'][0].toDouble(),
      json['start'][1].toDouble(),
    );

    final goal = Vector2(
      json['goal'][0].toDouble(),
      json['goal'][1].toDouble(),
    );

    // Parse holes as a list of Vector2
    final holes = (json['holes'] as List)
        .map((hole) => Vector2(hole[0].toDouble(), hole[1].toDouble()))
        .toList();
    final walls = (json['walls'] as List).map((wallData) {
      // wallData[0] is the position, wallData[1] is the SVG path string
      final position =
          Vector2(wallData[0][0].toDouble(), wallData[0][1].toDouble());
      final pathString = wallData[1] as String;
      final wall = Wall.fromString(pathString);
      wall.position = position; // Set the position for the wall
      wall.loadHitbox(); // Load the hitbox for the wall
      return wall;
    }).toList();
    return Maze._(start, goal, holes, walls);
  }
}
