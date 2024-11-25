import 'package:flutter/material.dart';
import 'package:labyrinth/bootstrap.dart';
import 'package:labyrinth/components/gui_common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/screens/screen_game.dart';

class ScreenLevels extends StatefulWidget {
  const ScreenLevels({super.key});

  @override
  State<ScreenLevels> createState() => _ScreenLevelsState();
}

class _ScreenLevelsState extends State<ScreenLevels> {
  bool _showLeaderboard = false;
  int _selectedNavIndex = 1;

  // Function to switch views
  void _resetViews() {
    setState(() {
      _showLeaderboard = false;
    });
  }

  void _onNavigationItemSelected(int index) {
    setState(() {
      _selectedNavIndex = index;
      if (index == 1) _resetViews();
      _showLeaderboard =
          index == 2; // Show leaderboard if leaderboard icon is selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: AppBackground(
            child: Row(
          children: [
            /// Side navigation menu
            Container(
              width: 80,
              color: Colors.transparent,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.arrow_back, size: 40),
                      onPressed: () => Navigator.pop(context)),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.menu, size: 40),
                      onPressed: () => _onNavigationItemSelected(0),
                      color:
                          _selectedNavIndex == 0 ? Colors.blue : Colors.black),
                  Divider(color: Colors.transparent),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.list,
                          size: 40,
                          color: _selectedNavIndex == 1
                              ? Colors.blue
                              : Colors.black),
                      onPressed: () => _onNavigationItemSelected(1)),
                  Divider(color: Colors.transparent),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.leaderboard,
                          size: 40,
                          color: _selectedNavIndex == 2
                              ? Colors.blue
                              : Colors.black),
                      onPressed: () => _onNavigationItemSelected(2)),
                  Divider(color: Colors.transparent),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.info,
                          size: 40,
                          color: _selectedNavIndex == 3
                              ? Colors.blue
                              : Colors.black),
                      onPressed: () => _onNavigationItemSelected(3)),
                  Divider(color: Colors.transparent),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.help,
                          size: 40,
                          color: _selectedNavIndex == 4
                              ? Colors.blue
                              : Colors.black),
                      onPressed: () => _onNavigationItemSelected(4)),
                ],
              ),
            ),

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
                          // Content based on selected view
                          Expanded(
                            flex: 3,
                            child: _showLeaderboard
                                ? Expanded(child: LeaderboardWidget())
                                : ListView.builder(
                                    itemCount: AppLoader.levels.length,
                                    itemBuilder: (context, index) {
                                      Level level = AppLoader.levels[index];
                                      return LevelTile(level: level);
                                    },
                                  ),
                          ),

                          // TODO: Change levels to be selectable, this information should come from the selected level
                          /// Right Panel for selected level's details
                          Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(15.00),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          style: TextStyle(color: Colors.white),
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
                                                horizontal: 60, vertical: 15),
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
                                                MainAxisAlignment.spaceBetween,
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
        )));
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

class LeaderboardWidget extends StatelessWidget {
  const LeaderboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('leaderboard')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No leaderboard data available'));
        }

        final leaderboardEntries = snapshot.data!.docs;

        return ListView.builder(
          itemCount: leaderboardEntries.length,
          itemBuilder: (context, index) {
            final entry = leaderboardEntries[index];
            final playerName = entry['name'];
            final timeString = entry['time'];
            final score = _parseTimeString(timeString);
            final formattedTime = _formatDuration(Duration(seconds: score));

            return ListTile(
              leading: Text(
                "#${index + 1}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              title: Text(playerName),
              trailing: Text(formattedTime),
            );
          },
        );
      },
    );
  }

  int _parseTimeString(String timeString) {
    final parts = timeString.split(':');
    final minutes = int.parse(parts[0]);
    final secondsParts = parts[1].split('.');
    final seconds = int.parse(secondsParts[0]);

    return minutes * 60 + seconds; // Convert to total seconds
  }

  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String milliseconds =
        (duration.inMilliseconds % 1000).toString().padLeft(3, '0');
    return "$minutes:$seconds.$milliseconds";
  }
}
