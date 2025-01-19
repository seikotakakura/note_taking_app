import 'package:note_taking_app/models/todo_model.dart';
import 'package:note_taking_app/services/database_helper.dart';

class TodoServices {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  //Add New Todo
  Future<int> addNewTodoForFile({required TodoModel todo, required int fileId}) async {
    final db = await _databaseHelper.database;
    return db.insert('todo_table', {
      ...todo.toTodoMap(),
      'file_id': fileId,
    });
  }

  //Update New Todo
  Future<int> updateNewTodoForFile({required TodoModel todo, required int todoId, required int fileId}) async {
    final db = await _databaseHelper.database;
    return db.update('todo_table', {
      ...todo.toTodoMap(),
      'file_id': fileId,
    }, where: '_id = ?', whereArgs: [todoId],);
  }

  //Get Todo from Specific File
  Future<List<TodoModel>> getTodosFromFile({required int fileId}) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'todo_table',
      where: 'file_id = ?',
      whereArgs: [fileId],
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => TodoModel.fromMap(maps[i]));
  }

  //Delete a Todo
  Future<int> deleteTodo({required int todoId}) async {
    final db = await _databaseHelper.database;
    return db.delete(
      'todo_table',
      where: '_id = ?',
      whereArgs: [todoId],
    );
  }
}
