import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/data/providers/settings_provider.dart';
import 'package:labyrinth/data/settings.dart';
import 'package:labyrinth/util/language_manager.dart';
import 'package:labyrinth/util/app_theme.dart';

class SettingsOverlay extends StatefulWidget {
  const SettingsOverlay({super.key});

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  /// Save a specific setting using the provided setter function
  Future<void> _updateSetting(Future<void> Function() updateFn) async {
    await updateFn();
    setState(() {});
  }

  Future<void> _saveLang(String lang) async {
    final settings = context.read<SettingsProvider>();
    await settings.setLanguage(lang);
  }

  void _showCredits() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        LanguageManager.instance
                            .translate('screen_settings_credits_dialog_title'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // TabBar
                  TabBar(
                    tabs: [
                      Tab(
                          text: LanguageManager.instance.translate(
                              'screen_settings_credits_tab_contributors')),
                      Tab(
                          text: LanguageManager.instance
                              .translate('screen_settings_credits_tab_music')),
                    ],
                  ),
                  // Content Area
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Contributors Tab
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Daniel Hinbest',
                                  style:
                                      TextStyle(fontSize: 16, inherit: true)),
                              Text('Jugal Patel',
                                  style:
                                      TextStyle(fontSize: 16, inherit: true)),
                              Text('Syed Rizvi',
                                  style:
                                      TextStyle(fontSize: 16, inherit: true)),
                              Text('Raje Singh',
                                  style:
                                      TextStyle(fontSize: 16, inherit: true)),
                              Text('Zachary Wayne',
                                  style:
                                      TextStyle(fontSize: 16, inherit: true)),
                              const SizedBox(
                                  height: 20), // Space between names and footer
                              Text(
                                'Mobile Devices Final Project',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  inherit: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Music Attribution Tab
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Music Attribution',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Impact Lento by Kevin MacLeod\n'
                                'Impact Allegretto by Kevin MacLeod\n',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              const Text(
                                'Both songs are licensed under a\n'
                                'Attribution 3.0 International License.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Close Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child:
                          Text(LanguageManager.instance.translate('btn_close')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showResetProgress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LanguageManager.instance
              .translate('screen_settings_score_reset_dialog_title')),
          content: Text(LanguageManager.instance
              .translate('screen_settings_score_reset_dialog_prompt')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(LanguageManager.instance.translate('btn_cancel')),
            ),
            TextButton(
              onPressed: () {
                // Add logic to reset progress here
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(LanguageManager.instance
                          .translate('screen_settings_score_reset_snackbar'))),
                );
              },
              child: Text(
                LanguageManager.instance.translate('btn_reset'),
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _restoreDefaults() async {
    final settings = context.read<SettingsProvider>();
    final tempMusic = settings.musicOn;
    final tempSfx = settings.sfxOn;
    final tempTimerVis = settings.timerVisible;
    final tempTiltControls = settings.tiltControls;
    final tempLang = settings.language;
    final tempTheme = settings.theme;
    await settings.reset();

    if (Settings.defaultLang != Settings.language) {
      await _saveLang(Settings.defaultLang);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LanguageManager.instance
              .translate('screen_settings_restore_default_snackbar')),
          action: SnackBarAction(
              label: LanguageManager.instance.translate('btn_undo'),
              onPressed: () async {
                settings.setMusic(tempMusic);
                settings.setSfx(tempSfx);
                settings.setTimerVisible(tempTimerVis);
                settings.setTiltControls(tempTiltControls);
                settings.setLanguage(tempLang);
                settings.setTheme(tempTheme);
                await _saveLang(tempLang);
                // _loadSettings();
              }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Stack(
      children: [
        // Semi-transparent background
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // Settings dialog
        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: getDecorationColor(settings.theme),
                borderRadius: BorderRadius.circular(20),
              ),
              child: DefaultTabController(
                length: 3, // Reduced to 3 tabs
                child: Column(
                  children: [
                    // Close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            child: Icon(Icons.close),
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    // TabBar for switching sections
                    TabBar(
                      tabs: const [
                        Tab(icon: Icon(Icons.settings)),
                        Tab(icon: Icon(Icons.gamepad_outlined)),
                        Tab(icon: Icon(Icons.info)),
                      ],
                    ),
                    // TabBarView for settings content
                    Flexible(
                      child: TabBarView(
                        children: [
                          // Tab 1 - General Settings
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  _buildSwitch(
                                    label: LanguageManager.instance.translate(
                                        'screen_settings_music_label'),
                                    value: settings.musicOn,
                                    onChanged: (value) =>
                                        _updateSetting(() async {
                                      // show snackbar
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Music is now ${value ? 'on' : 'off'}'),
                                          action: SnackBarAction(
                                              label: 'UNDO', onPressed: () {}),
                                        ),
                                      );

                                      await settings.setMusic(value);
                                      // isMusicOn = value;
                                    }),
                                  ),
                                  _buildSwitch(
                                    label: LanguageManager.instance.translate(
                                        'screen_settings_sound_label'),
                                    value: settings.sfxOn,
                                    onChanged: (value) =>
                                        _updateSetting(() async {
                                      await settings.setSfx(value);
                                      // isSfxOn = value;
                                    }),
                                  ),
                                  _buildLanguageDropdown(
                                    label: LanguageManager.instance.translate(
                                        'screen_settings_language_label'),
                                    value: settings.language,
                                    items: LanguageManager.availableLocales,
                                    onChanged: (value) async =>
                                        await _saveLang(value),
                                  ),
                                  _buildDropdown(
                                    label: LanguageManager.instance.translate(
                                        'screen_settings_theme_label'),
                                    value: settings.theme,
                                    items: AppTheme.values
                                        .map(
                                            (e) => e.toString().split('.').last)
                                        .toList(),
                                    onChanged: (value) =>
                                        _updateSetting(() async {
                                      await settings.setTheme(value);
                                      // selectedTheme = value;
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Tab 2 - Game Settings
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  _buildSwitch(
                                    label: LanguageManager.instance.translate(
                                        'screen_settings_timer_visibility_label'),
                                    value: settings.timerVisible,
                                    onChanged: (value) =>
                                        _updateSetting(() async {
                                      await settings.setTimerVisible(value);
                                      // isTimerVisible = value;
                                    }),
                                  ),
                                  _buildSwitch(
                                    label: LanguageManager.instance.translate(
                                        'screen_settings_tilt_control_label'),
                                    value: settings.tiltControls,
                                    onChanged: (value) =>
                                        _updateSetting(() async {
                                      await settings.setTiltControls(value);
                                      // isTiltControlsEnabled = value;
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Tab 3 - Other Settings
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GradientButton(
                                        text: LanguageManager.instance.translate(
                                            'screen_settings_restore_default_button'),
                                        icon: Icons.restore,
                                        onPressed: _restoreDefaults,
                                      ),
                                      GradientButton(
                                        text: LanguageManager.instance.translate(
                                            'screen_settings_score_reset_button'),
                                        icon: Icons.refresh,
                                        onPressed: _showResetProgress,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  GradientButton(
                                    text: LanguageManager.instance.translate(
                                        'screen_settings_credits_button'),
                                    icon: Icons.info_outline,
                                    onPressed: _showCredits,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Switch(
          value: value,
          onChanged: onChanged,
          // activeColor: Colors.black,
        ),
      ],
    );
  }

  Widget _buildLanguageDropdown({
    required String label,
    required String value,
    required Map<String, (Locale, String)> items,
    required ValueChanged<String> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        DropdownButton<String>(
          value: value,
          items: items.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value.$2), // Display the full language name
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        DropdownButton<String>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ],
    );
  }
}

// To show the overlay
void showSettingsOverlay(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => ScaffoldMessenger(
      child: Builder(
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: const SettingsOverlay());
        },
      ),
    ),
  );
}
