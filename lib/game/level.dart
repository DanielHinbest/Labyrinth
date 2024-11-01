import 'package:labyrinth/game/maze_data.dart';

class Level {
  final String name;
  final String description;
  final MazeData mazeData;

  Level._(this.name, this.description, this.mazeData);

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level._(
      json['name'] as String,
      json['description'] as String,
      json['mazeData'] as MazeData
    );
  }
}
