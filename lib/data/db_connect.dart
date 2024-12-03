import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBConnect {
  static Database? _database;

  Future<void> initDatabase() async {
    if (_database != null) return;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'labyrinth.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE scores(id INTEGER PRIMARY KEY, time INTEGER, level TEXT, date TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertScore(int time, String level, String date) async {
    final db = _database;
    if (db == null) return;

    await db.insert(
      'scores',
      {'time': time, 'level': level, 'date': date},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getScores(String level) async {
    final db = _database;
    if (db == null) return [];

    return await db.query(
      'scores',
      where: 'level = ?',
      whereArgs: [level],
      orderBy: 'time ASC',
    );
  }

  Future<int?> getBestTime(String level) async {
    final db = _database;
    if (db == null) return null;

    final result = await db.query(
      'scores',
      where: 'level = ?',
      whereArgs: [level],
      orderBy: 'time ASC',
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['time'] as int?;
    }
    return null;
  }

  Future<void> clearDatabase() async {
    final db = _database;
    if (db == null) return;

    await db.delete('scores');
    // print('Cleared all records from the local database');
  }
}
