import 'package:flutter/material.dart';

import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/screens/screen_levels.dart';
import 'package:labyrinth/screens/screen_settings.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: backgroundStack(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LABYRINTH',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4.0,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              _buildGradientButton(
                text: 'LEVELS',
                icon: Icons.play_arrow,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenLevels(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              _buildGradientButton(
                text: 'OPTIONS',
                icon: Icons.menu,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenSettings(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 240, // Fixed width to ensure both buttons are the same size
      decoration: BoxDecoration(
        // Maybe combine gradients or something to get a more similar effect?
        gradient: LinearGradient(
          colors: [
            Colors.grey[700]!,
            Colors.grey[800]!,
            Colors.grey[900]!,
            Colors.black.withOpacity(0.9),
            Colors.black,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          // stops: [0.2, 0.4, 0.6, 0.8, 1.0],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.transparent, // Make button background transparent
          shadowColor: Colors.transparent, // Remove button shadow
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(width: 10),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
