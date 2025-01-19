class TodoModel {
  final int? id;
  final int fileId;
  final String title;
  final String desc;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  TodoModel({
    this.id,
    required this.fileId,
    required this.title,
    required this.desc,
    this.isCompleted = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      fileId: map['file_id'],
      title: map['title'],
      desc: map['desc'],
      isCompleted: map['is_completed'] == 1 ? true : false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  Map<String, dynamic> toTodoMap() {
    return {
      'file_id': fileId,
      'title': title,
      'desc': desc,
      'is_completed': isCompleted ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }
}
