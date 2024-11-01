import 'package:labyrinth/util/point2d.dart';

class MazeData {
  final Point2D start;
  final Point2D goalHole;
  final List<Point2D> badHoles;

  MazeData(this.start, this.goalHole, this.badHoles);
}