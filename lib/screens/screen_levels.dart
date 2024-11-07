import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labyrinth/components/gui_common.dart';

import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/screens/screen_game.dart';
import 'package:labyrinth/util/logging.dart';

class ScreenLevels extends StatefulWidget {
  const ScreenLevels({super.key});

  @override
  State<ScreenLevels> createState() => _ScreenLevelsState();
}

class _ScreenLevelsState extends State<ScreenLevels> {
  // TODO: Move all asset loading to a bootstrapping function called on app startup (firebase init, level loading, etc.)
  Future<List<Level>> _loadLevels() async {
    List<Level> levels = [];

    String manifestContent =
        await rootBundle.loadString('assets/levels/levels.json');
    List<dynamic> levelFiles = jsonDecode(manifestContent);

    appLogger.d('Loading levels: $levelFiles');

    for (String path in levelFiles) {
      appLogger.d('Loading level: $path');
      String content = await rootBundle.loadString(path);
      Map<String, dynamic> jsonData = jsonDecode(content);
      appLogger.d('Data for $path: $jsonData');
      levels.add(Level.fromJson(jsonData));
    }

    appLogger.d('Loaded ${levels.length} levels');
    return levels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<List<Level>>(
        future: _loadLevels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            appLogger.e('Error Loading Levels', error: snapshot.error);
            return Center(child: Text('Error loading levels'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No levels found'));
          } else {
            List<Level> levels = snapshot.data!;
            return backgroundStack(Row(
              children: [
                /// Side navigation menu
                NavigationSidebar(),

                /// Main content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Level List
                              Expanded(
                                flex: 3,
                                child: ListView.builder(
                                  itemCount: levels.length,
                                  itemBuilder: (context, index) {
                                    Level level = levels[index];
                                    return LevelTile(level: level);
                                  },
                                ),
                              ),

                              /// Right Panel for selected level's details
                              Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: const EdgeInsets.all(15.00),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Easy Does It',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          color: Colors.grey,
                                          height: 200,
                                          width: double.infinity,
                                          child: Center(
                                            child: Text(
                                              'Maze Preview',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Level Description here!',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text('Your Time: Fast'),
                                        Text('Author Time: Slow'),
                                        Spacer(),
                                        Center(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 60,
                                                    vertical: 15),
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () {
                                                /// Begin button action
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.white,
                                                  ),
                                                  Text('Play',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18)),
                                                ],
                                              )),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
          }
        },
      ),
    );
  }
}

class NavigationSidebar extends StatelessWidget {
  const NavigationSidebar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: Colors.transparent,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back, size: 40),
              onPressed: () => Navigator.pop(context)),
          Icon(Icons.menu, size: 40),
          Divider(color: Colors.transparent),
          Icon(Icons.leaderboard, size: 40),
          Divider(color: Colors.transparent),
          Icon(Icons.info, size: 40),
          Divider(color: Colors.transparent),
          Icon(Icons.help, size: 40),
        ],
      ),
    );
  }
}

class LevelTile extends StatelessWidget {
  final Level level;

  const LevelTile({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Colors.green, Colors.teal],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ListTile(
          title: Text(
            level.name,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          trailing: Icon(Icons.arrow_forward, color: Colors.white),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenGame(level: level),
              ),
            );
          },
        ),
      ),
    );
  }
}
