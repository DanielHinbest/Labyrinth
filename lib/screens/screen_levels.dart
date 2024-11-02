import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import '../game/level.dart';
import 'screen_game.dart';

class ScreenLevels extends StatelessWidget {
  const ScreenLevels({super.key});

  Future<List<Level>> loadLevels() async {
    List<Level> levels = [];
    final directory = Directory('../levels');
    final levelFiles =
        directory.listSync().where((file) => file.path.endsWith('.level'));

    for (var file in levelFiles) {
      if (file is File) {
        String content = await file.readAsString();
        Map<String, dynamic> jsonData = jsonDecode(content);
        levels.add(Level.fromJson(
            jsonData)); // Assuming Level has a fromJson constructor
      }
    }
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
            print('snapshot.error: ${snapshot.error}');
            return Center(child: Text('Error loading levels')); // TODO: FIX
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
