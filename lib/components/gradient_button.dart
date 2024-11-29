import 'package:flutter/material.dart';

// TODO: Move to gui_common, really we want theme data in one place so we can switch themes easily
final defaultGradientColors = [
  Colors.grey[700]!,
  Colors.grey[800]!,
  Colors.grey[900]!,
  Colors.black,
];

class GradientButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final List<Color>? gradientColors;

  const GradientButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed,
      this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,

      /// Fixed width to ensure both buttons are the same size
      decoration: BoxDecoration(
        /// Maybe combine gradients or something to get a more similar effect?
        gradient: LinearGradient(
          colors: gradientColors ?? defaultGradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,

          /// stops: [0.2, 0.4, 0.6, 0.8, 1.0],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,

          /// Make button background transparent
          shadowColor: Colors.transparent,

          /// Remove button shadow
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: Text(text,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis))),
            SizedBox(width: 10),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
