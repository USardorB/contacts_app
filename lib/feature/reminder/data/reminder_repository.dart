import '../../../data/models/reminder_model.dart';

class ReminderRepository {
  static List<ReminderModel> getSampleReminders() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return [
      ReminderModel(
        id: '1',
        title: 'Call David',
        description: 'Discuss project timeline',
        dateTime: today.add(Duration(hours: 14, minutes: 0)), // 2:00 PM today
        isCompleted: false,
        createdAt: now.subtract(Duration(hours: 2)),
      ),
      ReminderModel(
        id: '2',
        title: 'Team Meeting',
        description: 'Weekly standup with development team',
        dateTime: today.add(Duration(hours: 10, minutes: 30)), // 10:30 AM today
        isCompleted: true,
        createdAt: now.subtract(Duration(days: 1)),
      ),
      ReminderModel(
        id: '3',
        title: 'Dentist Appointment',
        description: 'Regular checkup',
        dateTime: today
            .add(Duration(days: 1, hours: 15, minutes: 0)), // 3:00 PM tomorrow
        isCompleted: false,
        createdAt: now.subtract(Duration(hours: 6)),
      ),
      ReminderModel(
        id: '4',
        title: 'Submit Report',
        description: 'Monthly progress report due',
        dateTime: today.add(Duration(
            days: 2, hours: 9, minutes: 0)), // 9:00 AM day after tomorrow
        isCompleted: false,
        createdAt: now.subtract(Duration(days: 2)),
      ),
      ReminderModel(
        id: '5',
        title: 'Grocery Shopping',
        description: 'Buy ingredients for dinner',
        dateTime: today.add(Duration(hours: 18, minutes: 0)), // 6:00 PM today
        isCompleted: false,
        createdAt: now.subtract(Duration(hours: 1)),
      ),
    ];
  }
}
