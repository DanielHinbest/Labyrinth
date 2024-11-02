import 'package:flame/components.dart';
import 'package:labyrinth/game/wall.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class Maze {
  final Vector2 start;
  final Vector2 goal;
  final List<Vector2> holes;
  final List<Wall> walls;

  Maze._(this.start, this.goal, this.holes, this.walls);

  factory Maze.fromJson(Map<String, dynamic> json) {
    List<Wall> walls = [];
    for (List<dynamic> wallJson in json['walls']) {
      Vector2 position = wallJson[0] as Vector2;
      String pathString = wallJson[1] as String;
      final path = parseSvgPath(pathString);
      walls.add(Wall(position: position, path: path));
    }
    return Maze._(json['start'] as Vector2, json['goal'] as Vector2,
        json['holes'] as List<Vector2>, walls);
  }
}
