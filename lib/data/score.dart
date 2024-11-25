/// File: score.dart
/// Author: Daniel Hinbest
/// Date: 2024-11-02
/// Description: This file contains the implementation of the Score class, which represents a score record.
library;

class Score {
  final int id;
  final int score;
  final String date;

  Score({required this.id, required this.score, required this.date});

  /// Convert a Score object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'date': date,
    };
  }

  /// Create a Score object from a map
  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      id: map['id'],
      score: map['score'],
      date: map['date'],
    );
  }
}