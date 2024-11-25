/// File: db_connect.dart
/// Author: Daniel Hinbest
/// Date: 2024-11-02
/// Description: This file contains the implementation of the DBConnect class, which handles the SQLite database operations for the scores.
library;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'score.dart';

class DBConnect {
  late Database scoresDB;

  /// SQLite database instance

  /// Initialize the database
  Future<void> initDatabase() async {
    var dbPath = await getDatabasesPath();

    /// Get the path to the database
    String path = join(dbPath, 'scores.db');

    /// Set the database file path
    String sql = "CREATE TABLE scores ("
        "id INTEGER PRIMARY KEY, "
        "score INTEGER, "
        "date TEXT)";

    /// SQL query to create the scores table

    /// Open the database and create the table if it doesn't exist
    scoresDB =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(sql);

      /// Execute the SQL query
    });
  }

  /// Insert a new score record into the database
  Future<void> insertScore(Score score) async {
    await scoresDB.insert('scores', score.toMap(),

        /// Convert the score object to a map
        conflictAlgorithm: ConflictAlgorithm.replace

        /// Replace if a record with the same id exists
        );
  }

  /// Update an existing score record in the database
  Future<void> updateScore(Score score) async {
    await scoresDB.update('scores', score.toMap(),

        /// Convert the score object to a map
        where: 'id = ?',

        /// Specify the record to update
        whereArgs: [score.id]

        /// Provide the id of the record to update
        );
  }

  /// Delete a score record from the database
  Future<void> deleteScore(int id) async {
    await scoresDB.delete('scores',
        where: 'id = ?',

        /// Specify the record to delete
        whereArgs: [id]

        /// Provide the id of the record to delete
        );
  }

  /// Retrieve all score records from the database
  Future<List<Score>> getScores() async {
    final List<Map<String, dynamic>> maps = await scoresDB.query('scores');

    /// Query the database

    /// Convert the list of maps to a list of score objects
    return List.generate(maps.length, (i) {
      return Score.fromMap(maps[i]);
    });
  }
}
