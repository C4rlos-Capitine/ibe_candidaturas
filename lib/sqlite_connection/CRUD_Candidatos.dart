import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// Database helper class
class DatabaseHelper {
  static Future<Database> _getDatabase() async {
    final databasePath = join(await getDatabasesPath(), 'candidato.db');
    return openDatabase(databasePath, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE candidato (
          id INTEGER NOT NULL PRIMARY KEY,
          nome VARCHAR(25),
          apelido VARCHAR(50),
          email VARCHAR(50),
          senha VARCHAR(10),
          telefone VARCHAR(9),
          telemovel VARCHAR(9),
          genero VARCHAR(10),
          dia INTEGER,
          mes INTEGER,
          ano INTEGER,
          codprovi INTEGER
        );
      ''');
    });
  }

  // Create operation
  static Future<void> insertCandidato(Map<String, dynamic> candidato) async {
    final db = await _getDatabase();
    try {
      await db.insert(
        'candidato',
        candidato,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Error inserting candidato: $candidato');
    } catch (e) {
      print('Error inserting candidato: $e');
    } finally {
      await db.close();
    }
  }

  // Read operation
  static Future<List<Map<String, dynamic>>> getCandidatos() async {
    final db = await _getDatabase();
    try {
      return await db.query('candidato');
    } catch (e) {
      print('Error fetching candidatos: $e');
      return [];
    } finally {
      await db.close();
    }
  }

  // Update operation
  static Future<void> updateCandidato(int id, Map<String, dynamic> candidato) async {
    final db = await _getDatabase();
    try {
      await db.update(
        'candidato',
        candidato,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error updating candidato: $e');
    } finally {
      await db.close();
    }
  }

  // Delete operation
  static Future<void> deleteCandidato(int id) async {
    final db = await _getDatabase();
    try {
      await db.delete(
        'candidato',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting candidato: $e');
    } finally {
      await db.close();
    }
  }
}
