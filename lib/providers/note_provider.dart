import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/models/result.dart';
import 'package:note_taking_app/services/database_service.dart';

//provider untuk database
final noteProvider = Provider<DatabaseService>((ref) => DatabaseService());

//state notifier untuk mengelola state data
class NotesNotifier extends AsyncNotifier<List<NoteModel>> {
  @override
  FutureOr<List<NoteModel>> build() async {
    return await fetchNotes();
  }

  Future<List<NoteModel>> fetchNotes() async {
    try {
      final db = ref.read(noteProvider);
      return await db.getAllNotes();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  Future<Result> addNote(NoteModel note) async {
    try {
      final db = ref.read(noteProvider);
      int result = await db.addNote(note: note);

      if (result > 0) {
        state = AsyncValue.data(await fetchNotes());
        return Result.success("Note berhasil ditambahkan");
      } else {
        return Result.error("Gagal menambahkan note");
      }
    } catch (e) {
      return Result.success("Error: ${e.toString()}");
    }
  }

  Future<Result> updateNote(NoteModel note, int id) async {
    try {
      final db = ref.read(noteProvider);
      int result = await db.updateNote(note: note, noteId: id);

      if (result > 0) {
        state = AsyncValue.data(await fetchNotes());
        return Result.success("Note berhasil diubah");
      } else {
        return Result.error("Gagal mengubah note");
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      return Result.success("Error: ${e.toString()}");
    }
  }

  Future<Result> deleteNote(int id) async {
    try {
      final db = ref.read(noteProvider);
      int result = await db.deleteNoteDataById(id: id);

      if (result > 0) {
        state = AsyncValue.data(await fetchNotes());
        return Result.success("Note berhasil dihapus");
      } else {
        return Result.error("Gagal menghapus dihapus");
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      return Result.error("Error: ${e.toString()}");
    }
  }
}

//provider notes
final notesProvider = AsyncNotifierProvider<NotesNotifier, List<NoteModel>>(() {
  return NotesNotifier();
});
