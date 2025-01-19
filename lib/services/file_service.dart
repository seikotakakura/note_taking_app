import 'package:note_taking_app/models/file_model.dart';
import 'package:note_taking_app/services/database_helper.dart';

class FileService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  //Add New File
  Future<int> addNewFile({required FileModel file}) async {
    final db = await _databaseHelper.database;
    return await db.insert('file_table', file.toFileModelMap());
  }

  //Update New File
  Future<int> updateNewFile({FileModel? file, int? fileId}) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'file_table',
      file!.toFileModelMap(),
      where: '_id = ?',
      whereArgs: [fileId],
    );
  }

  //Get All File Data
  Future<List<FileModel>> getAllDataFile() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'file_table',
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) => FileModel.fromMap(maps[i]));
  }

  //Delete File Data (include todo)
  Future<int> deleteFile({required int id}) async {
    final db = await _databaseHelper.database;
    return db.delete(
      'file_table',
      where: '_id = ?',
      whereArgs: [id],
    );
  }
}
