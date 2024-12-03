import 'package:flutter/material.dart';
import 'package:labyrinth/data/settings.dart';
import 'package:labyrinth/util/audio_service.dart';
import 'package:labyrinth/util/language_manager.dart';
import 'package:labyrinth/util/logging.dart';

// Would be better to convert class to provider outright but eh wrapper will do for now
// TODO: Refactor all settings stuff to provider
class SettingsProvider extends ChangeNotifier {
  String _theme = Settings.theme;
  String _language = Settings.language;
  bool _musicOn = Settings.musicOn;
  bool _sfxOn = Settings.sfxOn;
  bool _timerVisible = Settings.timerVisible;
  bool _tiltControls = Settings.tiltControls;

  String get theme => _theme;
  String get language => _language;
  bool get musicOn => _musicOn;
  bool get sfxOn => _sfxOn;
  bool get timerVisible => _timerVisible;
  bool get tiltControls => _tiltControls;

  Future<void> setTheme(String theme) async {
    _theme = theme;
    await Settings.setTheme(theme);
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    await LanguageManager.delegate.load(Locale(language));
    appLogger.d('Language loaded: $language');
    _language = language;
    await Settings.setLanguage(language);
    notifyListeners();
  }

  Future<void> setMusic(bool musicOn) async {
    _musicOn = musicOn;
    if (_musicOn) {
      AudioService.instance.playBackgroundMusic(AudioService.menuBgm);
    } else {
      AudioService.instance.stopBackgroundMusic();
    }
    await Settings.setMusic(musicOn);
    notifyListeners();
  }

  Future<void> setSfx(bool sfxOn) async {
    _sfxOn = sfxOn;
    await Settings.setSfx(sfxOn);
    notifyListeners();
  }

  Future<void> setTimerVisible(bool visible) async {
    _timerVisible = visible;
    await Settings.setTimerVisible(visible);
    notifyListeners();
  }

  Future<void> setTiltControls(bool toggle) async {
    _tiltControls = toggle;
    await Settings.setTiltControls(toggle);
    notifyListeners();
  }

  Future<void> reset() async {
    await Settings.clear();
    _theme = Settings.theme;
    _language = Settings.language;
    _musicOn = Settings.musicOn;
    _sfxOn = Settings.sfxOn;
    _timerVisible = Settings.timerVisible;
    _tiltControls = Settings.tiltControls;
    notifyListeners();
  }
}
