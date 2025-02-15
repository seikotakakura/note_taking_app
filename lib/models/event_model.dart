class EventModel {
  final int? id;
  final String title;
  final String desc;
  final DateTime? eventStart;
  final DateTime? eventEnd;
  final bool isAllDay;
  final DateTime? reminderTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EventModel({
    this.id,
    required this.title,
    required this.desc,
    this.eventStart,
    this.eventEnd,
    this.isAllDay = false,
    this.reminderTime,
    this.createdAt,
    this.updatedAt
  });

  //conversion from Map to Model
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['_id'],
      title: map['title'],
      desc: map['desc'],
      eventStart: DateTime.fromMillisecondsSinceEpoch(map['event_start']),
      eventEnd: DateTime.fromMillisecondsSinceEpoch(map['event_end']),
      isAllDay: map['is_all_day'] == 0 ? false : true,
      reminderTime: DateTime.fromMicrosecondsSinceEpoch(map['reminder_time']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['event_start']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['event_end']),
    );
  }

  //conversion from Model to Map
  Map<String, dynamic> toEventMap() {
    return {
      '_id': id,
      'title': title,
      'desc': desc,
      'event_start': eventStart,
      'event_end': eventEnd,
      'is_all_day': isAllDay == false ? 0 : 1,
      'reminder_time': reminderTime,
      'created_at': createdAt == null
          ? DateTime.now().millisecondsSinceEpoch
          : createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt == null
          ? DateTime.now().millisecondsSinceEpoch
          : updatedAt?.millisecondsSinceEpoch,
    };
  }
}
