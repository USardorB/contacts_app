import '../../../domain/entities/reminder_entity.dart';

class ReminderModel extends ReminderEntity {
  const ReminderModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dateTime,
    super.isCompleted,
    required super.createdAt,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      dateTime:
          DateTime.parse(json['dateTime'] ?? DateTime.now().toIso8601String()),
      isCompleted: json['isCompleted'] ?? false,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReminderModel.create({
    required String title,
    required String description,
    required DateTime dateTime,
  }) {
    return ReminderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      dateTime: dateTime,
      createdAt: DateTime.now(),
    );
  }
}
