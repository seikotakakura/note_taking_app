import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/models/event_model.dart';
import 'package:note_taking_app/models/result.dart';
import 'package:note_taking_app/services/event_service.dart';

final eventProviderDb = Provider<EventService>((ref) => EventService());

class EventNotifier extends AsyncNotifier<List<EventModel>> {
  @override
  FutureOr<List<EventModel>> build() async {
    return await fetchEvent();
  }

  Future<List<EventModel>> fetchEvent() async {
    try {
      final db = ref.read(eventProviderDb);
      return await db.getAllEvent();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  Future<Result> addEvent(EventModel event) async {
    try {
      final db = ref.read(eventProviderDb);
      int result = await db.addEvent(event: event);

      if (result > 0) {
        state = AsyncValue.data(await fetchEvent());
        return Result.success("Event berhasil ditambahkan");
      } else {
        return Result.error("Gagal menambahkan event");
      }
    } catch (e) {
      return Result.error("Error: ${e.toString()}");
    }
  }

  Future<Result> updateEvent(EventModel event) async {
    try {
      final db = ref.read(eventProviderDb);
      int result = await db.updateEvent(event: event, eventId: event.id!);

      if (result > 0) {
        state = AsyncValue.data(await fetchEvent());
        return Result.success("Event berhasil diubah");
      } else {
        return Result.error("Gagal mengubah event");
      }
    } catch (e) {
      return Result.error("Error: ${e.toString()}");
    }
  }

  Future<Result> deleteEvent(int idEvent) async {
    try {
      final db = ref.read(eventProviderDb);
      int result = await db.deleteEventDataById(id: idEvent);

      if (result > 0) {
        state = AsyncValue.data(await fetchEvent());
        return Result.success("Event berhasil dihapus");
      } else {
        return Result.error("Gagal menghapus event");
      }
    } catch (e) {
      return Result.error("Error: ${e.toString()}");
    }
  }
}

final eventProvider = AsyncNotifierProvider<EventNotifier, List<EventModel>>(() {
  return EventNotifier();
});
