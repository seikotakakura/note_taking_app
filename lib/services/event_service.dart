import 'package:note_taking_app/models/event_model.dart';
import 'package:note_taking_app/services/database_helper.dart';

class EventService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  //get all Event data table
  Future<List<EventModel>> getAllEvent() async {
    final db = await _dbHelper.database;
    final result = await db.query('event_table');
    return result.map((map) => EventModel.fromMap(map)).toList();
  }

  //add Event data
  Future<int> addEvent({required EventModel event}) async {
    final db = await _dbHelper.database;
    return await db.insert('event_table', event.toEventMap());
  }

  //update Event data
  Future<int> updateEvent({required EventModel event, required int eventId}) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Event_table',
      event.toEventMap(),
      where: '_id = ?',
      whereArgs: [eventId],
    );
  }

  //delete Event data
  Future<int> deleteEventDataById({required int id}) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Event_table',
      where: '_id = ?',
      whereArgs: [id],
    );
  }
}