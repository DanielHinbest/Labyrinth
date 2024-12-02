import 'package:flutter/material.dart';

import 'package:labyrinth/bootstrap.dart';

import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/screens/screen_game.dart';

import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/components/leaderboard.dart';
import 'package:labyrinth/components/level_info.dart';
import 'package:labyrinth/components/search_overlay.dart';
import 'package:labyrinth/components/level_filter_modal.dart';
import 'package:labyrinth/util/language_manager.dart';
import 'package:labyrinth/components/local_scores.dart'; // Import LocalScores

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
  bool get _filtersApplied {
    return _selectedDifficulties.isNotEmpty || _selectedAuthors.isNotEmpty;
  }

  // Search-related states
  bool _isSearching = false; // Tracks if the search overlay is active

  @override
  void initState() {
    super.initState();
    _filteredLevels = _levels; // Start with the full list
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

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows content to take more space
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return LevelFilterModal(
          selectedDifficulties: _selectedDifficulties,
          selectedAuthors: _selectedAuthors,
          levels: _levels,
          onApplyFilters: (difficulties, authors) {
            setState(() {
              _selectedDifficulties = difficulties;
              _selectedAuthors = authors;
              _applyFilters();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ),
                  Divider(color: Colors.transparent),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      _filtersApplied
                          ? Icons.filter_alt
                          : Icons.filter_alt_off_outlined,
                      size: 40,
                    ),
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
                                        Level level = _filteredLevels[index];
                                        return LevelTile(
                                          level: level,
                                          trailing: _selectedLevelIndex == index
                                              ? const Icon(Icons.arrow_forward,
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
                                        dividerColor: Colors.transparent,
                                        tabs: [
                                          // Tab(icon: Icon(Icons.preview_outlined)),
                                          Tab(icon: Icon(Icons.info_outlined)),
                                          Tab(
                                              icon: Icon(
                                                  Icons.leaderboard_outlined)),
                                          Tab(
                                              icon:
                                                  Icon(Icons.archive_outlined)),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            LevelInfo(
                                                level: _filteredLevels[
                                                    _selectedLevelIndex]),
                                            Leaderboard(),
                                            LocalScores(
                                                level: _filteredLevels[
                                                        _selectedLevelIndex]
                                                    .name), // Use LocalScores widget
                                          ],
                                        ),
                                      ),
                                      Center(
                                          // width: 400,
                                          child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
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
                                                      Text(
                                                          LanguageManager
                                                              .instance
                                                              .translate(
                                                                  'btn_play'),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18)),
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