import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static const dbName = 'taking_note.db';
  static const dbVersion = 1;
  static const tableName = 'note_table';

  static const columnId = '_id';
  static const columnTitle = 'title';
  static const columnContent = 'content';
  static const columnDateCreated = 'date_created';
  static const columnDateUpdated = 'date_updated';
  static const columnNoteType = 'note_type';
  static const columnPosition = 'position';

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

  Future<Database> _initDatabase() async {
    final dbPath = await getApplicationDocumentsDirectory();
    return openDatabase(
      p.join(dbPath.path, dbName),
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE $tableName (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnTitle TEXT,
          $columnContent TEXT,
          $columnDateCreated INTEGER,
          $columnDateUpdated INTEGER,
          $columnNoteType TEXT,
          $columnPosition INTEGER
          )''');
      },
      version: dbVersion,
    );
  }

  //Setter testing database untuk akses _database
  set setTestDatabase(Database database) {
    _database = database;
  }
}
