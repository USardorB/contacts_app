import '../../../domain/entities/reminder_entity.dart';

class ReminderModel extends ReminderEntity {
  const ReminderModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dateTime,
    super.isCompleted,
    required super.createdAt,
    super.personId,
    super.personName,
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
      personId: json['personId']?.toString(),
      personName: json['personName']?.toString(),
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
      'personId': personId,
      'personName': personName,
    };
  }

  factory ReminderModel.create({
    required String title,
    required String description,
    required DateTime dateTime,
    String? personId,
    String? personName,
  }) {
    return ReminderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      dateTime: dateTime,
      createdAt: DateTime.now(),
      personId: personId,
      personName: personName,
    );
  }
}
