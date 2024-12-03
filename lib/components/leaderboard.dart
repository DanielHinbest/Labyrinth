import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Leaderboard extends StatelessWidget {
  final String level;

  const Leaderboard({required this.level});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('leaderboard')
          .where('level', isEqualTo: level)
          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No results found'));
        }

        final scores = snapshot.data!.docs;

        return ListView.builder(
          itemCount: scores.length,
          itemBuilder: (context, index) {
            final score = scores[index];
            return ListTile(
              title: Text('Name: ${score['name']}'),
              subtitle: Text('Time: ${score['time']} s\nDate: ${score['date']}'),
            );
          },
        );
      },
    );
  }
}