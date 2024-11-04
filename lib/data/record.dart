/// File: record.dart
/// Author: Daniel Hinbest
/// Date: 2024-11-02
/// Description: This file contains the implementation of the Record class, which represents a record in the Firestore database.

import 'package:cloud_firestore/cloud_firestore.dart';

/// TODO: Connect firebase to leaderboard screen

class Record {
  String? name;

  /// Name of the record
  String? time;

  /// Time associated with the record
  DocumentReference? reference;

  /// Reference to the Firestore document

  /// Constructor for the Record class
  Record({this.name, this.time, this.reference});

  /// Create a Record object from a map
  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'] as String?,
        time = map['time'] as String?;

  /// Convert a Record object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': time,
      'reference': reference,
    };
  }
}
