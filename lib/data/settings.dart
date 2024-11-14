import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static final Settings _instance = Settings._internal();
  static late final SharedPreferences _prefs;

  /// Private named constructor
  Settings._internal();

  /// Factory constructor returns the singleton instance
  factory Settings() {
    return _instance;
  }

  /// Asynchronous initialization for SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Example setters
  static Future<void> setId(int id) async {
    await _prefs.setInt('id', id);
  }

  static Future<void> setTheme(String theme) async {
    await _prefs.setString('theme', theme);
  }

  static Future<void> setSound(int sound) async {
    await _prefs.setInt('sound', sound);
  }
}
