import 'package:labyrinth/game/maze.dart';

class Level {
  final String name;
  final String description;
  final String difficulty;
  final Maze maze;

  Level._(this.name, this.description, this.difficulty, this.maze);

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level._(
      json['name'] as String,
      json['desc'] as String,
      json['diff'] as String,
      json['maze'] as Maze
    );
  }
}
