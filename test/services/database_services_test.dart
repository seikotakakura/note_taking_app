import 'package:flutter_test/flutter_test.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/models/note_type.dart';
import 'package:note_taking_app/services/database_helper.dart';
import 'package:note_taking_app/services/database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late DatabaseService databaseService;
  late Database database;

  const tableName = 'note_table';

  const columnId = '_id';
  const columnTitle = 'title';
  const columnContent = 'content';
  const columnDateCreated = 'date_created';
  const columnDateUpdated = 'date_updated';
  const columnNoteType = 'note_type';
  const columnPosition = 'position';

  setUp(() async {
    //inisiasi database FFI untuk testing
    sqfliteFfiInit();
    // databaseFactory = databaseFactoryFfi;

    //buat instance database in-memory
    database = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
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
      ),
    );

    //Mock DatabaseHelper untuk testing
    DatabaseHelper.instance.setTestDatabase = database;
    databaseService = DatabaseService();
  });

  tearDown(() async {
    //close database after testing
    await database.close();
  });

  // tearDownAll(() async {
  //   databaseFactory = sqfliteDatabaseFactoryDefault;
  // });

  group('Note Database Service Testing Operation', () {
    test('Should add a note', () async {
      final note = NoteModel(
        title: 'Test Note Title',
        content: 'Test Note Content',
        dateCreated: DateTime.now(),
        dateUpdated: null,
        position: 0,
      );

      final insertedId = await databaseService.addNote(note);
      expect(insertedId, isNotNull);

      final notes = await databaseService.getAllNotes();
      expect(notes.length, 1);
      expect(notes.first.title, 'Test Note Title');
      expect(notes.first.content, 'Test Note Content');
    });

    test('Should retrieve all data', () async {
      final note1 = NoteModel(
        title: 'Test Note Title',
        content: 'Test Note Content',
        dateCreated: DateTime.now(),
        dateUpdated: null,
        position: 0,
      );
      final note2 = NoteModel(
        title: 'Test Note Title2',
        content: 'Test Note Content2',
        dateCreated: DateTime.now(),
        dateUpdated: null,
        position: 1,
      );

      await databaseService.addNote(note1);
      await databaseService.addNote(note2);

      final notes = await databaseService.getAllNotes();
      expect(notes.length, 2);
      expect(notes[0].title, 'Test Note Title');
      expect(notes[1].title, 'Test Note Title2');
    });

    test('Should update a note', () async {
      final note = NoteModel(
        title: 'Test Note Title',
        content: 'Test Note Content',
        dateCreated: DateTime.now(),
        dateUpdated: DateTime.now(),
        position: 0,
      );

      final insertedId = await databaseService.addNote(note);

      final updateNote = NoteModel(
        id: insertedId,
        title: 'Updated Test Note Title',
        content: 'Updated Test Note Content',
        dateCreated: DateTime.now(),
        dateUpdated: DateTime.now(),
        noteType: NoteType.checklist,
        position: 0,
      );
      final rowAffected = await databaseService.updateNote(updateNote);

      expect(rowAffected, 1);

      final notes = await databaseService.getAllNotes();
      expect(notes.length, 1);
      expect(notes.first.title, 'Updated Test Note Title');
      expect(notes.first.content, 'Updated Test Note Content');
    });

    test('Should delete a note', () async {
      final note = NoteModel(
        title: 'Test Note Title',
        content: 'Test Note Content',
        dateCreated: DateTime.now(),
        dateUpdated: null,
        position: 0,
      );

      final insertedId = await databaseService.addNote(note);

      final rowDeleted = await databaseService.deleteNoteDataById(insertedId);

      expect(rowDeleted, 1);

      final notes = await databaseService.getAllNotes();
      expect(notes.isEmpty, true);
    });
  });
}
