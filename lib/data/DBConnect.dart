/// File: DBConnect.dart
/// Author: Daniel Hinbest
/// Date: 2024-11-02
/// Description: This file contains the implementation of the DBConnect class, which handles the SQLite database operations for the settings.

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'settings.dart';

// TODO: Connect the SQLite Database to screen_settings

class DBConnect {
  late Database settingsDB; // SQLite database instance

  // Initialize the database
  Future<void> initDatabase() async {
    var dbPath = await getDatabasesPath(); // Get the path to the database
    String path = join(dbPath, 'settings.db'); // Set the database file path
    String sql = "CREATE TABLE settings ("
                    "id INTEGER PRIMARY KEY, "
                    "theme TEXT, "
                    "sound TEXT)"; // SQL query to create the settings table

    // Open the database and create the table if it doesn't exist
    settingsDB = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(sql); // Execute the SQL query
      }
    );
  }

  // Insert a new settings record into the database
  Future<void> insertSettings(Settings settings) async {
    await settingsDB.insert(
      'settings',
      settings.toMap(), // Convert the settings object to a map
      conflictAlgorithm: ConflictAlgorithm.replace // Replace if a record with the same id exists
    );
  }

  // Update an existing settings record in the database
  Future<void> updateSettings(Settings settings) async {
    await settingsDB.update(
      'settings',
      settings.toMap(), // Convert the settings object to a map
      where: 'id = ?', // Specify the record to update
      whereArgs: [settings.id] // Provide the id of the record to update
    );
  }

  // Delete a settings record from the database
  Future<void> deleteSettings(int id) async {
    await settingsDB.delete(
      'settings',
      where: 'id = ?', // Specify the record to delete
      whereArgs: [id] // Provide the id of the record to delete
    );
  }

  // Retrieve all settings records from the database
  Future<List<Settings>> getSettings() async {
    final List<Map<String, dynamic>> maps = await settingsDB.query('users'); // Query the database

    // Convert the list of maps to a list of settings objects
    return List.generate(maps.length, (i) {
      return Settings.fromMap(maps[i]);
    });
  }
}