import 'package:flutter/material.dart';
import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/data/settings.dart';

class SettingsOverlay extends StatefulWidget {
  const SettingsOverlay({super.key});

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  bool isMusicOn = true; // State for Music toggle
  bool isSfxOn = true; // State for SFX toggle
  bool isTimerVisible = true; // State for Timer Visibility toggle
  bool isTiltControlsEnabled = false; // State for Tilt Controls toggle
  String selectedLanguage = 'English'; // State for Language dropdown
  String selectedTheme = 'Light'; // State for Theme dropdown

  final List<String> languages = ['English', 'Spanish', 'French', 'German'];
  final List<String> themes = ['Light', 'Dark', 'System'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// Load settings
  void _loadSettings() {
    setState(() {
      isMusicOn = Settings.musicOn;
      isSfxOn = Settings.sfxOn;
      isTimerVisible = Settings.timerVisible;
      isTiltControlsEnabled = Settings.tiltControls;
      selectedLanguage = Settings.language;
      selectedTheme = Settings.theme;
    });
  }

  /// Save a specific setting using the provided setter function
  Future<void> _updateSetting(Future<void> Function() updateFn) async {
    await updateFn();
    setState(() {});
  }

  void _showCredits() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Credits',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Daniel Hinbest', style: TextStyle(fontSize: 16)),
                Text('Jugal Patel', style: TextStyle(fontSize: 16)),
                Text('Syed Rizvi', style: TextStyle(fontSize: 16)),
                Text('Raje Singh', style: TextStyle(fontSize: 16)),
                Text('Zachary Wayne', style: TextStyle(fontSize: 16)),
                SizedBox(height: 20), // Space between names and footer
                // Footer text
                Text(
                  'Mobile Devices Final Project',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(5),
          actionsPadding: EdgeInsets.all(0),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Close'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showResetProgress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text(
              'This will remove all your score data! This cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add logic to reset progress here
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Progress reset successfully!')),
                );
              },
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _restoreDefaults() async {
    final tempMusic = isMusicOn;
    final tempSfx = isSfxOn;
    final tempTimerVis = isTimerVisible;
    final tempTiltControls = isTiltControlsEnabled;
    final tempLang = selectedLanguage;
    final tempTheme = selectedTheme;
    await Settings.clear();
    _loadSettings();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Settings restored to default!'),
          action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                Settings.setMusic(tempMusic);
                Settings.setSfx(tempSfx);
                Settings.setTimerVisible(tempTimerVis);
                Settings.setTiltControls(tempTiltControls);
                Settings.setLanguage(tempLang);
                Settings.setTheme(tempTheme);
                _loadSettings();
              }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                color: Colors.white,
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
                            child: Icon(Icons.close, color: Colors.black),
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    // TabBar for switching sections
                    TabBar(
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
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
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                _buildSwitch(
                                  label: 'Music',
                                  value: isMusicOn,
                                  onChanged: (value) =>
                                      _updateSetting(() async {
                                    await Settings.setMusic(value);
                                    isMusicOn = value;
                                  }),
                                ),
                                _buildSwitch(
                                  label: 'SFX',
                                  value: isSfxOn,
                                  onChanged: (value) =>
                                      _updateSetting(() async {
                                    await Settings.setSfx(value);
                                    isSfxOn = value;
                                  }),
                                ),
                                _buildDropdown(
                                  label: 'Language',
                                  value: selectedLanguage,
                                  items: languages,
                                  onChanged: (value) =>
                                      _updateSetting(() async {
                                    await Settings.setLanguage(value);
                                    selectedLanguage = value;
                                  }),
                                ),
                                _buildDropdown(
                                  label: 'Theme',
                                  value: selectedTheme,
                                  items: themes,
                                  onChanged: (value) =>
                                      _updateSetting(() async {
                                    await Settings.setTheme(value);
                                    selectedTheme = value;
                                  }),
                                ),
                              ],
                            ),
                          ),
                          // Tab 2 - Game Settings
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                _buildSwitch(
                                  label: 'Timer Visibility',
                                  value: isTimerVisible,
                                  onChanged: (value) =>
                                      _updateSetting(() async {
                                    await Settings.setTimerVisible(value);
                                    isTimerVisible = value;
                                  }),
                                ),
                                _buildSwitch(
                                  label: 'Tilt Controls',
                                  value: isTiltControlsEnabled,
                                  onChanged: (value) =>
                                      _updateSetting(() async {
                                    await Settings.setTiltControls(value);
                                    isTiltControlsEnabled = value;
                                  }),
                                ),
                              ],
                            ),
                          ),
                          // Tab 3 - Other Settings
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GradientButton(
                                      text: 'Restore Defaults',
                                      icon: Icons.restore,
                                      onPressed: _restoreDefaults,
                                    ),
                                    GradientButton(
                                      text: 'Reset Progress',
                                      icon: Icons.refresh,
                                      onPressed: _showResetProgress,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                GradientButton(
                                  text: 'Credits',
                                  icon: Icons.info_outline,
                                  onPressed: _showCredits,
                                ),
                              ],
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
          activeColor: Colors.black,
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
