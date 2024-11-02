import 'package:cloud_firestore/cloud_firestore.dart';
// TODO: Connect firebase to leaderboard screen

class Record {
  String? name;
  String? time;
  DocumentReference? reference;

  Record({this.name, this.time, this.reference});

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'] as String?,
        time = map['time'] as String?;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': time,
      'reference': reference,
    };
  }
}