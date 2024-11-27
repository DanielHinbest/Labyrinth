import 'package:flutter/material.dart';
import 'package:labyrinth/components/gui_common.dart';

class SettingsOverlay extends StatelessWidget {
  const SettingsOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Semi-transparent background
        GestureDetector(
          onTap: () => Navigator.of(context)
              .pop(), // Dismiss overlay when background is tapped
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        // Settings dialog
        Center(
          child: Card(
            color: Colors
                .transparent, // Ensures only the dialog has material properties
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: DefaultTabController(
                length: 4, // Number of tabs
                child: Column(
                  children: [
                    // TabBar for switching sections
                    TabBar(
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(icon: Icon(Icons.settings)),
                        Tab(icon: Icon(Icons.gamepad)),
                        Tab(icon: Icon(Icons.accessibility)),
                        Tab(icon: Icon(Icons.list)),
                      ],
                    ),
                    // TabBarView for settings content
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Tab 1 - General Settings
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ToggleButton(
                                  text: 'Music',
                                  onIcon: Icons.music_note,
                                  offIcon: Icons.music_off,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Music setting clicked')),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                ToggleButton(
                                  text: 'SFX',
                                  onIcon: Icons.volume_up,
                                  offIcon: Icons.volume_off,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('SFX setting clicked')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Tab 2 - Gameplay Settings
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GradientButton(
                                  text: 'Language',
                                  icon: Icons.language,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Language setting clicked')),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                GradientButton(
                                  text: 'Graphics',
                                  icon: Icons.photo,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Graphics setting clicked')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Tab 3 - Accessibility Settings
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GradientButton(
                                  text: 'Tutorials',
                                  icon: Icons.help,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Tutorials setting clicked')),
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
                          // Tab 4 - Other Settings
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  text: 'Save Slot',
                                  icon: Icons.save,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Save Slot clicked')),
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
