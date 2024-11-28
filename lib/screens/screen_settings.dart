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
  bool isTimerVisible = true; // State for Timer Visibility toggle
  bool isTiltControlsEnabled = false; // State for Tilt Controls toggle
  String selectedLanguage = 'English'; // State for Language dropdown
  String selectedTheme = 'Light'; // State for Theme dropdown

  final List<String> languages = ['English', 'Spanish', 'French', 'German'];
  final List<String> themes = ['Light', 'Dark', 'System'];

  void _showCredits() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Credits clicked')),
    );

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
                // List of placeholder names
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
          content: Text('This will remove all your score data!'),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 5),
                              child: Icon(Icons.close, color: Colors.black)),
                          onTap: () =>
                              Navigator.of(context).pop(), // Close overlay
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
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Timer Visibility',
                                        style: TextStyle(fontSize: 16)),
                                    Switch(
                                      value: isTimerVisible,
                                      onChanged: (value) {
                                        setState(() {
                                          isTimerVisible = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Tilt Controls',
                                        style: TextStyle(fontSize: 16)),
                                    Switch(
                                      value: isTiltControlsEnabled,
                                      onChanged: (value) {
                                        setState(() {
                                          isTiltControlsEnabled = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
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
                                  onPressed: _showCredits,
                                ),
                                SizedBox(height: 20),
                                GradientButton(
                                  text: 'Reset Progress',
                                  icon: Icons.refresh,
                                  onPressed: _showResetProgress,
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
    builder: (context) => ScaffoldMessenger(child: Builder(builder: (context) {
      return Scaffold(body: AppBackground(child: const SettingsOverlay()));
    })),
  );
}
