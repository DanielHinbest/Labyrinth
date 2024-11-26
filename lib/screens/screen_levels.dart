import 'package:flutter/material.dart';

import 'package:labyrinth/bootstrap.dart';

import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/screens/screen_game.dart';

import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/components/leaderboard.dart';
import 'package:labyrinth/components/level_info.dart';
import 'package:labyrinth/components/search_overlay.dart';

// TODO: Change to accept levels as a parameter, so the AppLoader levels are passed down tree (maybe)
class ScreenLevels extends StatefulWidget {
  const ScreenLevels({super.key});

  @override
  State<ScreenLevels> createState() => _ScreenLevelsState();
}

class _ScreenLevelsState extends State<ScreenLevels> {
  final List<Level> _levels = AppLoader.levels;
  final ScrollController _scrollController = ScrollController();

  // Filter-related states
  List<Level> _filteredLevels = []; // Filtered levels to display
  int _selectedLevelIndex = 0;
  Set<int> _selectedDifficulties = {};
  Set<String?> _selectedAuthors = {};
  bool _filtersApplied = false;

  // Search-related states
  bool _isSearching = false; // Tracks if the search overlay is active

  @override
  void initState() {
    super.initState();
    _filteredLevels = _levels; // Start with the full list
  }

  // TODO: Extract to a separate file
  void _showFilterBottomSheet() {
    final screenSize = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows content to take more space
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Temporary selections to allow canceling
        Set<int> tempSelectedDifficulties = {..._selectedDifficulties};
        Set<String?> tempSelectedAuthors = {..._selectedAuthors};

        // Recalculate valid filters based on current selections
        Set<int> availableDifficulties = _getAvailableDifficulties(
          tempSelectedAuthors,
        );
        Set<String?> availableAuthors = _getAvailableAuthors(
          tempSelectedDifficulties,
        );

        final ScrollController difficultyController = ScrollController();
        final ScrollController authorController = ScrollController();

        return StatefulBuilder(builder: (context, setModalState) {
          // Helper to update options dynamically as user selects filters
          void updateAvailableFilters() {
            setModalState(() {
              availableDifficulties =
                  _getAvailableDifficulties(tempSelectedAuthors);
              availableAuthors = _getAvailableAuthors(tempSelectedDifficulties);

              // Remove invalid selections
              tempSelectedDifficulties.removeWhere(
                  (difficulty) => !availableDifficulties.contains(difficulty));
              tempSelectedAuthors
                  .removeWhere((author) => !availableAuthors.contains(author));
            });
          }

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
                                  controller: difficultyController,
                                  child: ListView(children: [
                                    ...[0, 1, 2].map((difficulty) {
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
                                        onChanged: availableDifficulties
                                                .contains(difficulty)
                                            ? (value) {
                                                setModalState(() {
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
                                            : null, // Disable if no levels match this difficulty
                                      );
                                    })
                                  ]))),
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
                                  controller: authorController,
                                  child: ListView(children: [
                                    ..._levels
                                        .map((level) => level.author)
                                        .toSet()
                                        .map((author) {
                                      return CheckboxListTile(
                                        title: Text(
                                          author,
                                          style: TextStyle(
                                            color: availableAuthors
                                                    .contains(author)
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                        value: tempSelectedAuthors
                                            .contains(author),
                                        onChanged: availableAuthors
                                                .contains(author)
                                            ? (value) {
                                                setModalState(() {
                                                  if (value == true) {
                                                    tempSelectedAuthors
                                                        .add(author);
                                                  } else {
                                                    tempSelectedAuthors
                                                        .remove(author);
                                                  }
                                                  updateAvailableFilters();
                                                });
                                              }
                                            : null, // Disable if no levels match this author
                                      );
                                    })
                                  ]))),
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
                      onPressed: () {
                        Navigator.pop(
                            context); // Close without applying filters
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                        onPressed: () {
                          setModalState(() {
                            tempSelectedDifficulties.clear();
                            tempSelectedAuthors.clear();
                            _filtersApplied = false;
                            updateAvailableFilters(); // Reset options
                          });
                        },
                        child: const Text("Clear")),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedDifficulties = tempSelectedDifficulties;
                          _selectedAuthors = tempSelectedAuthors;
                          _filtersApplied = _selectedDifficulties.isNotEmpty ||
                              _selectedAuthors.isNotEmpty;
                          _applyFilters();
                        });
                        Navigator.pop(context); // Apply filters and close
                      },
                      child: const Text("Apply"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  /// Helper to calculate available difficulties based on levels
  /// Dynamically calculate available difficulties based on selected authors
  Set<int> _getAvailableDifficulties(Set<String?> selectedAuthors) {
    if (selectedAuthors.isEmpty) {
      return _levels.map((level) => level.difficulty).toSet();
    }
    return _levels
        .where((level) => selectedAuthors.contains(level.author))
        .map((level) => level.difficulty)
        .toSet();
  }

  /// Helper to calculate available authors based on levels
  /// Dynamically calculate available authors based on selected difficulties
  Set<String?> _getAvailableAuthors(Set<int> selectedDifficulties) {
    if (selectedDifficulties.isEmpty) {
      return _levels.map((level) => level.author).toSet();
    }
    return _levels
        .where((level) => selectedDifficulties.contains(level.difficulty))
        .map((level) => level.author)
        .toSet();
  }

  /// Apply the selected filters
  void _applyFilters() {
    setState(() {
      _filteredLevels = _levels.where((level) {
        // Match difficulty
        bool matchesDifficulty = _selectedDifficulties.isEmpty ||
            _selectedDifficulties.contains(level.difficulty);
        // Match author
        bool matchesAuthor =
            _selectedAuthors.isEmpty || _selectedAuthors.contains(level.author);
        return matchesDifficulty && matchesAuthor;
      }).toList();

      _selectedLevelIndex = 0; // Reset selected level index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: AppBackground(
            child: Stack(
          children: [
            Row(
              children: [
                /// Side navigation menu
                Container(
                  width: 60,
                  color: Colors.transparent,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.arrow_back, size: 40),
                          onPressed: () => Navigator.pop(context)),
                      Divider(color: Colors.transparent),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.search, size: 40),
                          onPressed: () {
                            setState(() {
                              _isSearching = true; // Show search overlay
                            });
                          },
                          color: Colors.black),
                      Divider(color: Colors.transparent),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                            _filtersApplied
                                ? Icons.filter_alt
                                : Icons.filter_alt_off_outlined,
                            size: 40,
                            color: Colors.black),
                        onPressed: _showFilterBottomSheet,
                      ),
                      Divider(color: Colors.transparent),
                    ],
                  ),
                ),

                /// Main content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Scrollbar(
                                    controller: _scrollController,
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: ListView.builder(
                                          itemCount: _filteredLevels.length,
                                          itemBuilder: (context, index) {
                                            Level level =
                                                _filteredLevels[index];
                                            return LevelTile(
                                              level: level,
                                              trailing:
                                                  _selectedLevelIndex == index
                                                      ? const Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.white)
                                                      : null,
                                              onTap: () {
                                                setState(() {
                                                  _selectedLevelIndex = index;
                                                });
                                              },
                                            );
                                          },
                                        ))),
                              ),
                              // SizedBox(width: 10),
                              /// Right Panel for selected level's details
                              DefaultTabController(
                                  length: 3,
                                  child: Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text(
                                            _filteredLevels[_selectedLevelIndex]
                                                .name,
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TabBar(
                                            indicatorColor: Colors.blue,
                                            labelColor: Colors.blue,
                                            dividerColor: Colors.transparent,
                                            tabs: [
                                              // Tab(icon: Icon(Icons.preview_outlined)),
                                              Tab(
                                                  icon: Icon(
                                                      Icons.info_outlined)),
                                              Tab(
                                                  icon: Icon(Icons
                                                      .leaderboard_outlined)),
                                              Tab(
                                                  icon: Icon(
                                                      Icons.archive_outlined)),
                                            ],
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                LevelInfo(
                                                    level: _filteredLevels[
                                                        _selectedLevelIndex]),
                                                Leaderboard(),
                                                Center(
                                                    child:
                                                        Text('Local Scores')),
                                              ],
                                            ),
                                          ),
                                          Center(
                                              // width: 400,
                                              child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        // padding: EdgeInsets.symmetric(
                                                        //     horizontal: 60, vertical: 0),
                                                        backgroundColor:
                                                            Colors.black,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        /// Begin button action
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ScreenGame(
                                                                    level: _filteredLevels[
                                                                        _selectedLevelIndex]),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.white,
                                                          ),
                                                          Text('Play',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      18)),
                                                        ],
                                                      )))),
                                        ],
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Search overlay (visible only when searching)
            if (_isSearching)
              SearchOverlay(
                levels: _levels,
                onClose: () {
                  setState(() {
                    _isSearching = false; // Hide search overlay
                  });
                },
              ),
          ],
        )));
  }
}
