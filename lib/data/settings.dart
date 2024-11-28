import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static final Settings _instance = Settings._internal();
  static late final SharedPreferencesWithCache _prefs;
  static const _allowList = <String>{
    'theme',
    'music_on',
    'sfx_on',
    'lang',
    'timer_visible',
    'use_tilt'
  };

  /// Private named constructor
  Settings._internal();

  /// Factory constructor returns the singleton instance
  factory Settings() {
    return _instance;
  }

  // Getters
  static String get theme => _prefs.getString('theme') ?? 'Light';
  static bool get musicOn => _prefs.getBool('music_on') ?? true;
  static bool get sfxOn => _prefs.getBool('sfx_on') ?? true;
  static String get language => _prefs.getString('lang') ?? 'English';
  static bool get timerVisible => _prefs.getBool('timer_visible') ?? true;
  static bool get tiltControls => _prefs.getBool('use_tilt') ?? false;

// TODO: some work required to get system default language and theme

  /// Asynchronous initialization for SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: _allowList,
      ),
    );
  }

  // Example setters
  static Future<void> setTheme(String theme) async {
    await _prefs.setString('theme', theme);
  }

  static Future<void> setMusic(bool sound) async {
    await _prefs.setBool('music_on', sound);
  }

  static Future<void> setSfx(bool sound) async {
    await _prefs.setBool('sfx_on', sound);
  }

  static Future<void> setLanguage(String lang) async {
    await _prefs.setString('lang', lang);
  }

  static Future<void> setTimerVisible(bool visible) async {
    await _prefs.setBool('timer_visible', visible);
  }

  static Future<void> setTiltControls(bool toggle) async {
    await _prefs.setBool('use_tilt', toggle);
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }

  // Function to check if a key is set
  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
