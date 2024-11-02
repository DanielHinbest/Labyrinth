import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'settings.dart';

class DBConnect {
  late Database settingsDB;

  Future<void> initDatabase() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'settings.db');
    String sql = "CREATE TABLE settings ("
                    "id INTEGER PRIMARY KEY, "
                    "theme TEXT, "
                    "sound TEXT)";

    settingsDB = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(sql);
      }
    );
  }

  Future<void> insertSettings(Settings settings) async {
    await settingsDB.insert(
      'settings',
      settings.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> updateSettings(Settings settings) async {
    await settingsDB.update(
      'settings',
      settings.toMap(),
      where: 'id = ?',
      whereArgs: [settings.id]
    );
  }

  Future<void> deleteSettings(int id) async {
    await settingsDB.delete(
      'settings',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<List<Settings>> getSettings() async {
    final List<Map<String, dynamic>> maps = await settingsDB.query('users');

    return List.generate(maps.length, (i) {
      return Settings.fromMap(maps[i]);
    });
  }
}