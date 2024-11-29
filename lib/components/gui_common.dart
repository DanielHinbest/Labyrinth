import 'package:labyrinth/util/language_manager.dart';

export 'package:labyrinth/components/gradient_button.dart';
export 'package:labyrinth/components/toggle_button.dart';
export 'package:labyrinth/components/app_background.dart';
export 'package:labyrinth/components/level_tile.dart';

/// Helper to get the label for difficulties
String getDifficultyLabel(int difficulty) {
  switch (difficulty) {
    case 0:
      return LanguageManager.instance.translate('difficulty_easy');
    case 1:
      return LanguageManager.instance.translate('difficulty_medium');
    case 2:
      return LanguageManager.instance.translate('difficulty_hard');
    default:
      return "???";
  }
}
