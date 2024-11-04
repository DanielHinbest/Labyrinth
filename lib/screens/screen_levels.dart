import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/screens/screen_game.dart';
import 'package:labyrinth/util/logging.dart';

class ScreenLevels extends StatelessWidget {
  const ScreenLevels({super.key});

  Future<List<Level>> loadLevels() async {
    List<Level> levels = [];

    // Load the manifest file
    String manifestContent =
        await rootBundle.loadString('assets/levels/levels.json');
    List<dynamic> levelFiles = jsonDecode(manifestContent);

    appLogger.d('Loading levels: $levelFiles');

    // Load each level file listed in the manifest
    for (String path in levelFiles) {
      appLogger.d('Loading level: $path');
      String content = await rootBundle.loadString(path);
      Map<String, dynamic> jsonData = jsonDecode(content);
      appLogger.d('Data for $path: $jsonData');
      levels.add(Level.fromJson(
          jsonData)); // Assuming Level has a fromJson constructor
    }

    appLogger.d('Loaded ${levels.length} levels');

    return levels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level Selection'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Level>>(
        future: loadLevels(),
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
            return ListView.builder(
              itemCount: levels.length,
              itemBuilder: (context, index) {
                Level level = levels[index];
                return ListTile(
                  title: Text(level.name), // Assuming Level has a name property
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenGame(level: level),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
