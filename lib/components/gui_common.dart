export 'package:labyrinth/components/gradient_button.dart';
export 'package:labyrinth/components/toggle_button.dart';
export 'package:labyrinth/components/app_background.dart';
export 'package:labyrinth/components/level_tile.dart';

/// Helper to get the label for difficulties
String getDifficultyLabel(int difficulty) {
  switch (difficulty) {
    case 0:
      return "Easy";
    case 1:
      return "Medium";
    case 2:
      return "Hard";
    default:
      return "Unknown";
  }
}
