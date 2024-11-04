/// File: settings.dart
/// Author: Daniel Hinbest
/// Date: 2024-11-02
/// Description: This file contains the implementation of the Settings class, which represents the settings data model.
library;

class Settings {
  int? id;

  /// ID of the settings record
  String? theme;

  /// Theme setting
  int? sound;

  /// Sound setting (this data type might need to be changed later)

  /// Constructor for the Settings class
  Settings({this.id, this.theme, this.sound});

  /// Create a Settings object from a map
  Settings.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    theme = map['theme'];
    sound = map['sound'];
  }

  /// Convert a Settings object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'theme': theme,
      'sound': sound,
    };
  }
}
