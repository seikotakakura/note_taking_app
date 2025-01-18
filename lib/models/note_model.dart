import 'package:note_taking_app/models/note_type.dart';

class NoteModel {
  final int? id;
  final String title;
  final String content;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;
  final NoteType noteType;
  final int position;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    this.dateCreated,
    this.dateUpdated,
    this.noteType = NoteType.textNote,
    required this.position,
  });

  //conversion from Map to Model
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['_id'],
      title: map['title'],
      content: map['content'],
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['date_created']),
      dateUpdated: map['date_updated'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(map['date_updated']),
      noteType: map['note_type'] == 'Text Note' ? NoteType.textNote : map['note_type'] == 'Checklist' ? NoteType.checklist : NoteType.voiceNote,
      position: map['position'],
    );
  }

  //conversion from Model to Map
  Map<String, dynamic> toNoteMap() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'date_created': dateCreated == null ? DateTime.now().millisecondsSinceEpoch : dateCreated?.millisecondsSinceEpoch,
      'date_updated': dateUpdated == null ? DateTime.now().millisecondsSinceEpoch : dateUpdated?.millisecondsSinceEpoch,
      'note_type': noteType == NoteType.textNote ? 'Text Note' : noteType == NoteType.checklist ? 'Checklist' : 'Voice Note',
      'position': position,
    };
  }
}
