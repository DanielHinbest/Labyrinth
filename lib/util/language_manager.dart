import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:labyrinth/util/logging.dart';

// Wanted a different approach from the generated code from the flutter localization tool (l10n.yaml, flutter_gen, arb files), so used the following with
// some modifications from this open source project: https://github.com/peercoin/peercoin_flutter/blob/main/lib/tools/app_localizations.dart
// Credit to the peercoin_flutter contributors
// License AGPL-3.0
/// Handles the localization of the app
class LanguageManager {
  static late LanguageManager instance;

  static const Map<String, (Locale, String)> availableLocales = {
    'de': (Locale('de'), 'Deutsch'),
    'fr': (Locale('fr'), 'Français'),
    'en': (Locale('en'), 'English'),
    'es': (Locale('es'), 'Español'),
  };

  static const LocalizationsDelegate<LanguageManager> delegate =
      _AppLocalizationsDelegate();

  final Locale fallbackLocale = const Locale('en');

  Locale locale;

  late Map<String, String> _localizedStrings;

  late Map<String, String> _fallbackLocalizedStrings;

  LanguageManager(this.locale);

  // make factory
  factory LanguageManager._init(Locale locale) {
    instance = LanguageManager(locale);
    return instance;
  }

  Future<void> load() async {
    _localizedStrings = await _loadLocalizedStrings(locale);
    _fallbackLocalizedStrings = {};

    if (locale != fallbackLocale) {
      _fallbackLocalizedStrings = await _loadLocalizedStrings(fallbackLocale);
    }
  }

  String translate(String key, [Map<String, String?>? arguments]) {
    var translation = _localizedStrings[key];
    translation = translation ?? _fallbackLocalizedStrings[key];
    translation = translation ?? '';

    if (arguments == null || arguments.isEmpty) {
      return translation;
    }

    arguments.forEach((argumentKey, value) {
      if (value == null) {
        appLogger.w(
          'Value for "$argumentKey" is null in call of translate(\'$key\')',
        );
        value = '';
      }
      translation = translation!.replaceAll('\$$argumentKey', value);
    });

    return translation ?? '';
  }

  Future<String> _getFilePath(Locale localeToBeLoaded) async {
    return 'assets/lang/${localeToBeLoaded.languageCode}.json';
  }

  Future<Map<String, String>> _loadLocalizedStrings(
    Locale localeToBeLoaded,
  ) async {
    String jsonString;
    var localizedStrings = <String, String>{};

    try {
      jsonString =
          await rootBundle.loadString(await _getFilePath(localeToBeLoaded));
    } catch (e) {
      appLogger.e(
        e.toString(),
      );
      return localizedStrings;
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return localizedStrings;
  }

  static LanguageManager? of(BuildContext context) {
    return Localizations.of<LanguageManager>(context, LanguageManager);
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<LanguageManager> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return LanguageManager.availableLocales.containsKey(locale.languageCode);
  }

  @override
  Future<LanguageManager> load(Locale locale) async {
    var localizations = LanguageManager._init(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
