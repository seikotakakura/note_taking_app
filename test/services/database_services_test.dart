import 'package:flutter_test/flutter_test.dart';
import 'package:note_taking_app/models/file_model.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/models/note_type.dart';
import 'package:note_taking_app/models/todo_model.dart';
import 'package:note_taking_app/services/database_helper.dart';
import 'package:note_taking_app/services/database_service.dart';
import 'package:note_taking_app/services/file_service.dart';
import 'package:note_taking_app/services/todo_services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late DatabaseService databaseService;
  late FileService fileService;
  late TodoServices todoService;
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
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE $tableName (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnTitle TEXT,
          $columnContent TEXT,
          $columnDateCreated INTEGER,
          $columnDateUpdated INTEGER,
          $columnNoteType TEXT,
          $columnPosition INTEGER
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
        },
        onOpen: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
      ),
    );

    //Mock DatabaseHelper untuk testing
    DatabaseHelper.instance.setTestDatabase = database;
    databaseService = DatabaseService();
    fileService = FileService();
    todoService = TodoServices();
  });

  tearDown(() async {
    //close database after testing
    await database.close();
  });

  // tearDownAll(() async {
  //   databaseFactory = sqfliteDatabaseFactoryDefault;
  // });

  test('Test Pragma Foreign Key', () async {
    final isActive = await database.rawQuery('PRAGMA foreign_keys');
    expect(isActive.first.values.first, 1);
  });

  group('Note Database Service Testing Operation', () {
    test('Should add a note', () async {
      final note = NoteModel(
        title: 'Test Note Title',
        content: 'Test Note Content',
        dateCreated: DateTime.now(),
        dateUpdated: null,
        position: 0,
      );

      final insertedId = await databaseService.addNote(note: note);
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

      await databaseService.addNote(note: note1);
      await databaseService.addNote(note: note2);

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

      final insertedId = await databaseService.addNote(note: note);

      final updateNote = NoteModel(
        id: insertedId,
        title: 'Updated Test Note Title',
        content: 'Updated Test Note Content',
        dateCreated: DateTime.now(),
        dateUpdated: DateTime.now(),
        noteType: NoteType.checklist,
        position: 0,
      );
      final rowAffected = await databaseService.updateNote(
        note: updateNote,
        noteId: insertedId,
      );

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

      final insertedId = await databaseService.addNote(note: note);

      final rowDeleted =
          await databaseService.deleteNoteDataById(id: insertedId);

      expect(rowDeleted, 1);

      final notes = await databaseService.getAllNotes();
      expect(notes.isEmpty, true);
    });
  });

  group('File and Todo Service Test', () {
    test('Add a File test', () async {
      final file = FileModel(
        fileName: 'File Test 1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final insertFile = await fileService.addNewFile(file: file);
      expect(insertFile, 1);
      expect(insertFile, isNotNull);

      final files = await fileService.getAllDataFile();
      expect(files.length, 1);
      expect(files.first.fileName, 'File Test 1');
    });

    test('Add a ToDo test', () async {
      final file = FileModel(
        fileName: 'File Test 1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final fileId = await fileService.addNewFile(file: file);

      final todo = TodoModel(
        fileId: fileId,
        title: 'To Do Test 1',
        desc: 'Desc To Do',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final insertTodo =
          await todoService.addNewTodoForFile(todo: todo, fileId: fileId);
      expect(insertTodo, 1);
      expect(insertTodo, isNotNull);

      final files = await todoService.getTodosFromFile(fileId: fileId);
      expect(files.length, 1);
      expect(files.first.title, 'To Do Test 1');
    });

    test('Update a File and Todo test', () async {
      final file = FileModel(
        fileName: 'File Test',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final insertId = await fileService.addNewFile(file: file);
      expect(insertId, 1);
      expect(insertId, isNotNull);

      final todo = TodoModel(
        fileId: insertId,
        title: 'To Do Test 1',
        desc: 'Desc To Do',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final insertTodo = await todoService.addNewTodoForFile(
        todo: todo,
        fileId: insertId,
      );
      expect(insertTodo, 1);
      expect(insertTodo, isNotNull);

      final updatedFile = FileModel(
        fileName: 'Updated File Test',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final updateFile = await fileService.updateNewFile(
        file: updatedFile,
        fileId: insertId,
      );
      expect(updateFile, 1);
      expect(updateFile, isNotNull);

      final updatedTodo = TodoModel(
        fileId: insertId,
        title: 'Updated To Do Test 1',
        desc: 'Updated Desc To Do',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final updateTodo = await todoService.updateNewTodoForFile(
        todo: updatedTodo,
        todoId: insertTodo,
        fileId: insertId,
      );
      expect(updateTodo, 1);

      final files = await fileService.getAllDataFile();
      expect(files.length, 1);
      expect(files.first.fileName, 'Updated File Test');

      final todos = await todoService.getTodosFromFile(fileId: insertId);
      expect(todos.length, 1);
      expect(todos.first.title, 'Updated To Do Test 1');
    });

    test('Delete a File and ToDo Test', () async {
      final file = FileModel(
        fileName: 'File Test',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final insertId = await fileService.addNewFile(file: file);
      expect(insertId, 1);
      expect(insertId, isNotNull);

      final todo = TodoModel(
        fileId: insertId,
        title: 'To Do Test',
        desc: 'To Do Test Desc',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final insertedTodo = await todoService.addNewTodoForFile(
        todo: todo,
        fileId: insertId,
      );
      expect(insertedTodo, 1);
      expect(insertedTodo, isNotNull);

      final deleteFile = await fileService.deleteFile(id: insertId);
      expect(deleteFile, 1);

      final files = await fileService.getAllDataFile();
      expect(files.isEmpty, true);
      final todos = await todoService.getTodosFromFile(fileId: insertId);
      expect(todos.isEmpty, true);
    });

    test('Delete Just a ToDo Test', () async {
      final file = FileModel(
        fileName: 'File Test',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final insertId = await fileService.addNewFile(file: file);
      expect(insertId, 1);
      expect(insertId, isNotNull);

      final todo = TodoModel(
        fileId: insertId,
        title: 'To Do Test',
        desc: 'To Do Test Desc',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final insertedTodo = await todoService.addNewTodoForFile(
        todo: todo,
        fileId: insertId,
      );
      expect(insertedTodo, 1);
      expect(insertedTodo, isNotNull);

      final deleteTodo = await todoService.deleteTodo(todoId: insertedTodo);
      expect(deleteTodo, 1);

      final files = await fileService.getAllDataFile();
      expect(files.isEmpty, false);
      final todos = await todoService.getTodosFromFile(fileId: insertId);
      expect(todos.isEmpty, true);
    });
  });
}
