import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static const dbName = 'taking_note.db';
  static const dbVersion = 1;

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static DatabaseHelper get instance => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> deleteDatabaseFile() async {
    String path = p.join(await getDatabasesPath(), dbName);
    if (await File(path).exists()) {
      await deleteDatabase(path);
      log("Database deleted successfully!");
    }
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getApplicationDocumentsDirectory();
    return openDatabase(
      p.join(dbPath.path, dbName),
      onCreate: (db, version) async {
        //Create Note Table
        await db.execute('''CREATE TABLE note_table (
          _id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT NOT NULL,
          content TEXT,
          created_at INTEGER,
          updated_at INTEGER
          )''');

        // Create File Table
        await db.execute('''
          CREATE TABLE file_table (
          _id INTEGER PRIMARY KEY AUTOINCREMENT,
          file_name TEXT NOT NULL,
          created_at INTEGER,
          updated_at INTEGER
          )''');

        //Create Todo Table
        await db.execute('''
          CREATE TABLE todo_table (
          _id INTEGER PRIMARY KEY AUTOINCREMENT,
          file_id INTEGER NOT NULL,
          title TEXT NOT NULL,
          desc TEXT,
          is_completed INTEGER NOT NULL DEFAULT 0,
          created_at INTEGER,
          updated_at INTEGER,
          FOREIGN KEY (file_id) REFERENCES file_table (_id) ON DELETE CASCADE
          )''');

        //Create event table
        await db.execute('''
        CREATE TABLE event_table(
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        desc TEXT NOT NULL,
        event_start INTEGER,
        event_end INTEGER,
        is_all_day INTEGER NOT NULL DEFAULT 0,
        reminder_time INTEGER,
        created_at INTEGER,
        updated_at INTEGER
        )''');
      },
      version: dbVersion,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  //Setter testing database untuk akses _database
  set setTestDatabase(Database database) {
    _database = database;
  }
}
