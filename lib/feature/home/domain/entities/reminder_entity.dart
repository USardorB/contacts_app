class ReminderEntity {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isCompleted;
  final DateTime createdAt;
  final String? personId;
  final String? personName;

  const ReminderEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
    required this.createdAt,
    this.personId,
    this.personName,
  });

  ReminderEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    bool? isCompleted,
    DateTime? createdAt,
    String? personId,
    String? personName,
  }) {
    return ReminderEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      personId: personId ?? this.personId,
      personName: personName ?? this.personName,
    );
  }
}
