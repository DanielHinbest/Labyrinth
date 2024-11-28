import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

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
