import 'package:flutter/material.dart';
import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/game/level.dart';

class LevelInfo extends StatelessWidget {
  final Level level;
  final ScrollController scrollController = ScrollController();
  LevelInfo({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.00),
        child: Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            flex: 1,
                            child: Container(
                              color: Colors.grey,
                              height: 250,
                              child: Center(
                                child: Text(
                                  'Maze Preview',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                        // SizedBox(height: 20),
                        Flexible(
                            flex: 2,
                            child: Row(
                              children: [
                                Text('Author: ${level.author}'),
                                Spacer(),
                                Text(
                                    'Difficulty: ${getDifficultyLabel(level.difficulty)}'),
                              ],
                            )),
                        Flexible(
                            flex: 3,
                            child: Text(
                              level.description,
                              style: TextStyle(fontSize: 16),
                            )),
                      ],
                    )))));
  }
}
