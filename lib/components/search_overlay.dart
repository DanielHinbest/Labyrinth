import 'package:flutter/material.dart';
import 'package:labyrinth/components/gui_common.dart';
import 'package:labyrinth/game/level.dart';
import 'package:labyrinth/screens/screen_game.dart';

/// A reusable SearchOverlay widget.
class SearchOverlay extends StatefulWidget {
  final List<Level> levels; // All levels to search through
  final void Function() onClose; // Callback for closing the overlay

  const SearchOverlay({
    super.key,
    required this.levels,
    required this.onClose,
  });

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  List<Level> _searchResults = []; // Holds search results
  String _searchQuery = ""; // Tracks the current search query

  /// Perform a fuzzy search on levels
  void _searchLevels(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _searchResults = widget.levels.where((level) {
        final nameMatch = level.name.toLowerCase().contains(_searchQuery);
        final difficultyMatch = getDifficultyLabel(level.difficulty)
            .toLowerCase()
            .contains(_searchQuery);
        final authorMatch = (level.author).toLowerCase().contains(_searchQuery);
        return nameMatch || difficultyMatch || authorMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.black.withOpacity(0.6), // Semi-transparent background
        child: Column(
          children: [
            // Search Bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      onChanged: _searchLevels,
                      decoration: InputDecoration(
                        hintText:
                            "Search levels by name, difficulty, or author...",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: widget.onClose, // Trigger close callback
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search Results
            Expanded(
              child: _searchQuery.isNotEmpty && _searchResults.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "No results found for '$_searchQuery'",
                        style: TextStyle(color: Colors.white70),
                      ))
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final level = _searchResults[index];
                        // TODO: Change to use level tile
                        return ListTile(
                          title: Text(level.name,
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text(
                            "Difficulty: ${getDifficultyLabel(level.difficulty)}, Author: ${level.author}",
                            style: TextStyle(color: Colors.white70),
                          ),
                          onTap: () {
                            // Navigate to ScreenGame with the selected level
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenGame(level: level),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
