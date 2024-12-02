import 'package:flutter/material.dart';
import 'package:labyrinth/data/db_connect.dart';

class LocalScores extends StatelessWidget {
  final String level;

  const LocalScores({required this.level});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DBConnect().getScores(level),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final scores = snapshot.data!;
        if (scores.isEmpty) {
          return Center(child: Text('No scores available'));
        }

        return ListView.builder(
          itemCount: scores.length,
          itemBuilder: (context, index) {
            final score = scores[index];
            return ListTile(
              title: Text('Time: ${score['time']} s'),
              subtitle: Text('Level: ${score['level']}'),
            );
          },
        );
      },
    );
  }
}