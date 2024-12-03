import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'maze.dart';
import 'marble.dart';
import 'hole.dart';
import 'goal.dart';

class GameLabyrinth extends Forge2DGame {
  final Maze maze;
  final List<Hole> holes = [];
  Goal? goal; // Change to a single goal object
  final Function onGoalReached; // Callback to stop the timer
  bool _goalReached = false; // Flag to track if the goal has been reached

  GameLabyrinth(this.maze, this.onGoalReached) : super(gravity: Vector2.zero());

  Marble? marble;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print('World type: ${world.runtimeType}');

    Vector2 marbleSpawnPosition = maze.start;

    marble = Marble(marbleSpawnPosition);
    await world.add(marble!);
    await Future.wait(maze.walls.map((wall) async => await world.add(wall)));
    for (final hole in maze.holes) {
      holes.add(hole);
      await world.add(hole);
    }

    // Create and add the goal object
    goal = Goal(center: maze.goal, radius: 5.0);
    await world.add(goal!);

    // Set initial camera position and zoom
    camera.viewfinder.zoom = 1.8;
    camera.moveTo(Vector2(230, 100));
  }

  @override
  void update(double dt) {
    super.update(dt);
    checkCollisions();
  }

  void checkCollisions() {
    if (marble == null || marble!.body == null) return;

    for (final hole in holes) {
      if (hole.body == null) continue;
      if (isColliding(marble!, hole)) {
        print('Marble entered the hole');
        marble!.shrinkAndDisappear();
      }
    }

    if (!_goalReached &&
        goal != null &&
        goal!.body != null &&
        isColliding(marble!, goal!)) {
      print('Marble reached the goal');
      goal!.changeMarbleColorToRainbow(marble!);
      _goalReached = true;
      onGoalReached(); // Ensure this is called
    }
  }

  bool isColliding(Marble marble, BodyComponent component) {
    final marblePosition = marble.body?.position;
    final componentPosition = component.body?.position;
    if (marblePosition == null || componentPosition == null) return false;

    final distance = marblePosition.distanceTo(componentPosition);
    final collisionThreshold = marble.shape.radius +
        (component is Hole ? component.radius : (component as Goal).radius);
    print('Distance: $distance');
    print('Collision threshold: $collisionThreshold');

    return distance < collisionThreshold;
  }
}
