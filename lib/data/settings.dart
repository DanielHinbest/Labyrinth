import 'package:flutter/material.dart';

class Settings {
  int? id;
  String? theme;
  int? sound; // This data type might need to be changed later

  Settings({this.id, this.theme, this.sound});

  Settings.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    theme = map['theme'];
    sound = map['sound'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'theme': theme,
      'sound': sound
    };
  }
}