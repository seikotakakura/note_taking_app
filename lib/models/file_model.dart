class FileModel {
  final int? id;
  final String fileName;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileModel({
    this.id,
    required this.fileName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      fileName: map['file_name'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  Map<String, dynamic> toFileModelMap() {
    return {
      'file_name': fileName,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }
}
