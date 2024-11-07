import 'package:labyrinth/game/maze.dart';

class Level {
  final String name;
  final String description;
  final String author;
  final int difficulty;
  final Maze maze;

  Level._(this.name, this.description, this.author, this.difficulty, this.maze);

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level._(
        json['name'] as String,
        json['desc'] as String,
        json['auth'] as String,
        json['diff'] as int,
        Maze.fromJson(json['maze']));
  }
}
