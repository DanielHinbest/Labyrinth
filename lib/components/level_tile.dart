import 'package:flutter/material.dart';

import 'package:labyrinth/game/level.dart';

class LevelTile extends StatelessWidget {
  final Level level;
  final VoidCallback onTap;
  final Icon? trailing;

  const LevelTile(
      {super.key,
      required this.level,
      required this.trailing,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // gradient: LinearGradient(
            //   colors: [Colors.green, Colors.teal],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            // ),

            // Change color depending on level difficulty 0 - green, 1 - orange, 2 - red
            color: level.difficulty == 0
                ? Colors.green
                : level.difficulty == 1
                    ? Colors.orange
                    : Colors.red),
        child: ListTile(
          title: Text(
            level.name,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}
