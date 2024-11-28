import 'package:flutter/material.dart';
import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/game/level.dart';

/// This widget is a modal that allows the user to filter levels by difficulty
/// and author. It does not modify the levels directly, but instead calls a
/// callback function, and you can apply the filters to the levels in the parent
/// based on the selected difficulties and authors.
/// ```dart
/// LevelFilterModal(
///   selectedDifficulties: selectedDifficulties,
///   selectedAuthors: selectedAuthors,
///   levels: levels,
///   onApplyFilters: (difficulties, authors) {
///    // Apply filters to levels e.g.:
///       setState(() {
///       filteredLevels = levels.where((level) => difficulties.contains(level.difficulty) && authors.contains(level.author)).toList();
///    });
/// },
/// ```
class LevelFilterModal extends StatefulWidget {
  final Set<int> selectedDifficulties;
  final Set<String?> selectedAuthors;
  final List<Level> levels;
  final Function(Set<int>, Set<String?>) onApplyFilters;

  const LevelFilterModal({
    super.key,
    required this.selectedDifficulties,
    required this.selectedAuthors,
    required this.levels,
    required this.onApplyFilters,
  });

  @override
  State<LevelFilterModal> createState() => _LevelFilterModalState();
}

class _LevelFilterModalState extends State<LevelFilterModal> {
  late Set<int> tempSelectedDifficulties;
  late Set<String?> tempSelectedAuthors;
  late Set<int> availableDifficulties;
  late Set<String?> availableAuthors;

  final ScrollController _difficultyController = ScrollController();
  final ScrollController _authorController = ScrollController();

  @override
  void initState() {
    super.initState();
    tempSelectedDifficulties = {...widget.selectedDifficulties};
    tempSelectedAuthors = {...widget.selectedAuthors};
    availableDifficulties = _getAvailableDifficulties(tempSelectedAuthors);
    availableAuthors = _getAvailableAuthors(tempSelectedDifficulties);
  }

  void updateAvailableFilters() {
    setState(() {
      availableDifficulties = _getAvailableDifficulties(tempSelectedAuthors);
      availableAuthors = _getAvailableAuthors(tempSelectedDifficulties);

      // Remove invalid selections
      tempSelectedDifficulties.removeWhere(
          (difficulty) => !availableDifficulties.contains(difficulty));
      tempSelectedAuthors
          .removeWhere((author) => !availableAuthors.contains(author));
    });
  }

  Set<int> _getAvailableDifficulties(Set<String?> selectedAuthors) {
    if (selectedAuthors.isEmpty) {
      return widget.levels.map((level) => level.difficulty).toSet();
    }
    return widget.levels
        .where((level) => selectedAuthors.contains(level.author))
        .map((level) => level.difficulty)
        .toSet();
  }

  Set<String?> _getAvailableAuthors(Set<int> selectedDifficulties) {
    if (selectedDifficulties.isEmpty) {
      return widget.levels.map((level) => level.author).toSet();
    }
    return widget.levels
        .where((level) => selectedDifficulties.contains(level.difficulty))
        .map((level) => level.author)
        .toSet();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          const Text(
            "Filter Levels",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Filter content in two columns
          Row(
            children: [
              // Difficulty column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Difficulty",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.5,
                      child: Scrollbar(
                          controller: _difficultyController,
                          child: ListView(
                            children: [0, 1, 2].map((difficulty) {
                              return CheckboxListTile(
                                title: Text(
                                  getDifficultyLabel(difficulty),
                                  style: TextStyle(
                                    color: availableDifficulties
                                            .contains(difficulty)
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                value: tempSelectedDifficulties
                                    .contains(difficulty),
                                onChanged:
                                    availableDifficulties.contains(difficulty)
                                        ? (value) {
                                            setState(() {
                                              if (value == true) {
                                                tempSelectedDifficulties
                                                    .add(difficulty);
                                              } else {
                                                tempSelectedDifficulties
                                                    .remove(difficulty);
                                              }
                                              updateAvailableFilters();
                                            });
                                          }
                                        : null,
                              );
                            }).toList(),
                          )),
                    ),
                  ],
                ),
              ),

              // Author column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Authors",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.5,
                      child: Scrollbar(
                          controller: _authorController,
                          child: ListView(
                            children: widget.levels
                                .map((level) => level.author)
                                .toSet()
                                .map((author) {
                              return CheckboxListTile(
                                title: Text(
                                  author,
                                  style: TextStyle(
                                    color: availableAuthors.contains(author)
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                value: tempSelectedAuthors.contains(author),
                                onChanged: availableAuthors.contains(author)
                                    ? (value) {
                                        setState(() {
                                          if (value == true) {
                                            tempSelectedAuthors.add(author);
                                          } else {
                                            tempSelectedAuthors.remove(author);
                                          }
                                          updateAvailableFilters();
                                        });
                                      }
                                    : null,
                              );
                            }).toList(),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    Navigator.pop(context), // Close without applying
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    tempSelectedDifficulties.clear();
                    tempSelectedAuthors.clear();
                    updateAvailableFilters(); // Reset options
                  });
                },
                child: const Text("Clear"),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onApplyFilters(
                      tempSelectedDifficulties, tempSelectedAuthors);
                  Navigator.pop(context); // Apply filters and close
                },
                child: const Text("Apply"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
