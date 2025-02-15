import 'package:note_taking_app/models/note_type.dart';

class NoteModel {
  final int? id;
  final String title;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // final NoteType noteType;
  // final int position;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt,
    // this.noteType = NoteType.textNote,
    // required this.position,
  });

  //conversion from Map to Model
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['_id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: map['updated_at'] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      // noteType: map['note_type'] == 'Text Note' ? NoteType.textNote : map['note_type'] == 'Checklist' ? NoteType.checklist : NoteType.voiceNote,
      // position: map['position'],
    );
  }

  //conversion from Model to Map
  Map<String, dynamic> toNoteMap() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'crated_at': createdAt == null ? DateTime.now().millisecondsSinceEpoch : createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt == null ? DateTime.now().millisecondsSinceEpoch : updatedAt?.millisecondsSinceEpoch,
      // 'note_type': noteType == NoteType.textNote ? 'Text Note' : noteType == NoteType.checklist ? 'Checklist' : 'Voice Note',
      // 'position': position,
    };
  }
}
