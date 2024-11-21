import 'package:flutter/material.dart';
import 'package:labyrinth/components/gradient_button.dart';

class ToggleButton extends StatefulWidget {
  final String text;
  final IconData onIcon;
  final IconData offIcon;
  final VoidCallback onPressed;

  const ToggleButton(
      {super.key,
      required this.text,
      required this.onIcon,
      required this.offIcon,
      required this.onPressed});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isOn = true;

  void toggle() {
    setState(() {
      isOn = !isOn;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        text: widget.text,
        icon: isOn ? widget.onIcon : widget.offIcon,
        onPressed: () {
          setState(() {
            isOn = !isOn;
          });
        });
  }
}
