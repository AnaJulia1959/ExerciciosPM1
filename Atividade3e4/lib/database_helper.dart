import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'travel_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cars (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            KM_perL REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE destinations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nomeCidade TEXT,
            KM REAL
          )
        ''');
      },
    );
  }

  Future<int> insertCar(Map<String, dynamic> car) async {
    final db = await database;
    return await db.insert('cars', car);
  }

  Future<int> insertDestination(Map<String, dynamic> destination) async {
    final db = await database;
    return await db.insert('destinations', destination);
  }

  Future<List<Map<String, dynamic>>> getCars() async {
    final db = await database;
    return await db.query('cars');
  }

  Future<List<Map<String, dynamic>>> getDestinations() async {
    final db = await database;
    return await db.query('destinations');
  }

  Future<int> deleteCar(int id) async {
    final db = await database;
    return await db.delete('cars', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDestination(int id) async {
    final db = await database;
    return await db.delete('destinations', where: 'id = ?', whereArgs: [id]);
  }
}
