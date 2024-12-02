import 'dart:convert';

import 'package:labyrinth/util/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:labyrinth/data/user.dart';

class Settings {
  static final Settings _instance = Settings._internal();
  static late final SharedPreferencesWithCache _prefs;
  static const _allowList = <String>{
    'theme',
    'music_on',
    'sfx_on',
    'lang',
    'timer_visible',
    'use_tilt',
    'user'
  };
  static String defaultLang = 'en';

  /// Private named constructor
  Settings._internal();

  /// Factory constructor returns the singleton instance
  factory Settings() {
    return _instance;
  }

  // Getters
  static String get theme => _prefs.getString('theme') ?? 'System';
  static bool get musicOn => _prefs.getBool('music_on') ?? true;
  static bool get sfxOn => _prefs.getBool('sfx_on') ?? true;
  static String get language => _prefs.getString('lang') ?? defaultLang;
  static bool get timerVisible => _prefs.getBool('timer_visible') ?? true;
  static bool get tiltControls => _prefs.getBool('use_tilt') ?? false;

  /// Get the stored User object or return null if not set
  static User get user {
    final userJson = _prefs.getString('user');
    appLogger.d('User JSON: $userJson');
    if (userJson == null) {
      User user = User.offline();
      setUser(user);
      return user;
    }

    return User.fromJson(Map<String, dynamic>.from(
        json.decode(userJson) as Map<String, dynamic>));
  }

  /// Asynchronous initialization for SharedPreferences
  static Future<void> init({String defaultLang = 'en'}) async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: _allowList,
      ),
    );

    defaultLang = defaultLang;
    if (_prefs.getString('lang') == null) {
      await _prefs.setString('lang', defaultLang);
    }

    if (_prefs.getString('user') == null) {
      await setUser(User.offline());
    }
  }

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

  /// Save the User object as a JSON string
  static Future<void> setUser(User user) async {
    final userJson = json.encode(user.toJson());
    await _prefs.setString('user', userJson);
  }

  /// Remove the User object
  static Future<void> clearUser() async {
    await _prefs.remove('user');
  }
}
