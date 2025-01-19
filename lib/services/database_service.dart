import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/services/database_helper.dart';

class DatabaseService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  //get all note data table
  Future<List<NoteModel>> getAllNotes() async {
    final db = await _dbHelper.database;
    final result = await db.query('note_table');
    return result.map((map) => NoteModel.fromMap(map)).toList();
  }

  //add note data
  Future<int> addNote({required NoteModel note}) async {
    final db = await _dbHelper.database;
    return await db.insert('note_table', note.toNoteMap());
  }

  //update note data
  Future<int> updateNote({required NoteModel note, required int noteId}) async {
    final db = await _dbHelper.database;
    return await db.update(
      'note_table',
      note.toNoteMap(),
      where: '_id = ?',
      whereArgs: [noteId],
    );
  }

  //delete note data
  Future<int> deleteNoteDataById({required int id}) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'note_table',
      where: '_id = ?',
      whereArgs: [id],
    );
  }
}
