import 'package:flutter/material.dart';
import 'package:labyrinth/components/gui_common.dart';

class SettingsOverlay extends StatefulWidget {
  const SettingsOverlay({super.key});

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  bool isMusicOn = true; // State for Music toggle
  bool isSfxOn = true; // State for SFX toggle
  String selectedLanguage = 'English'; // State for Language dropdown
  String selectedTheme = 'Light'; // State for Theme dropdown

  final List<String> languages = ['English', 'Spanish', 'French', 'German'];
  final List<String> themes = ['Light', 'Dark', 'System'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Semi-transparent background
        GestureDetector(
          onTap: () => Navigator.of(context)
              .pop(), // Dismiss overlay when background is tapped
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
                    // Back button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () =>
                              Navigator.of(context).pop(), // Close overlay
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    // TabBar for switching sections
                    TabBar(
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
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
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('SFX',
                                          style: TextStyle(fontSize: 16)),
                                      Switch(
                                        value: isSfxOn,
                                        onChanged: (value) {
                                          setState(() {
                                            isSfxOn = value;
                                          });
                                        },
                                      ),
                                      Text('Music',
                                          style: TextStyle(fontSize: 16)),
                                      Switch(
                                        value: isMusicOn,
                                        onChanged: (value) {
                                          setState(() {
                                            isMusicOn = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Language',
                                          style: TextStyle(fontSize: 16)),
                                      SizedBox(
                                          width: 150,
                                          child: DropdownButton<String>(
                                            value: selectedLanguage,
                                            isExpanded: true,
                                            items: languages
                                                .map((String language) {
                                              return DropdownMenuItem<String>(
                                                value: language,
                                                child: Text(language),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedLanguage = newValue!;
                                              });
                                            },
                                          )),
                                      Text('Theme',
                                          style: TextStyle(fontSize: 16)),
                                      SizedBox(
                                        width: 150,
                                        child: DropdownButton<String>(
                                          value: selectedTheme,
                                          isExpanded: true,
                                          items: themes.map((String theme) {
                                            return DropdownMenuItem<String>(
                                              value: theme,
                                              child: Text(theme),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedTheme = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Tab 2 - Language Settings
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Pain')],
                            ),
                          ),
                          // Tab 3 - Other Settings
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GradientButton(
                                  text: 'Credits',
                                  icon: Icons.info_outline,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Credits clicked')),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                GradientButton(
                                  text: 'Reset Progress',
                                  icon: Icons.refresh,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Reset Progress clicked')),
                                    );
                                  },
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
}

// To show the overlay, call this method
void showSettingsOverlay(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Dismiss the overlay by tapping outside
    builder: (context) => const SettingsOverlay(),
  );
}
