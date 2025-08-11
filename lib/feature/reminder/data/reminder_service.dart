import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../home/data/models/reminder_model.dart';
import 'reminder_repository.dart';

class ReminderService {
  static const String _storageKey = 'reminders';

  // Get all reminders
  Future<List<ReminderModel>> getReminders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final remindersJson = prefs.getStringList(_storageKey) ?? [];

      return remindersJson
          .map((json) => ReminderModel.fromJson(jsonDecode(json)))
          .toList()
        ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    } catch (e) {
      print('Error getting reminders: $e');
      return [];
    }
  }

  // Add a new reminder
  Future<bool> addReminder(ReminderModel reminder) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final reminders = await getReminders();
      reminders.add(reminder);

      final remindersJson =
          reminders.map((reminder) => jsonEncode(reminder.toJson())).toList();

      return await prefs.setStringList(_storageKey, remindersJson);
    } catch (e) {
      print('Error adding reminder: $e');
      return false;
    }
  }

  // Update a reminder
  Future<bool> updateReminder(ReminderModel reminder) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final reminders = await getReminders();

      final index = reminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        reminders[index] = reminder;

        final remindersJson =
            reminders.map((reminder) => jsonEncode(reminder.toJson())).toList();

        return await prefs.setStringList(_storageKey, remindersJson);
      }
      return false;
    } catch (e) {
      print('Error updating reminder: $e');
      return false;
    }
  }

  // Delete a reminder
  Future<bool> deleteReminder(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final reminders = await getReminders();

      reminders.removeWhere((r) => r.id == id);

      final remindersJson =
          reminders.map((reminder) => jsonEncode(reminder.toJson())).toList();

      return await prefs.setStringList(_storageKey, remindersJson);
    } catch (e) {
      print('Error deleting reminder: $e');
      return false;
    }
  }

  // Toggle reminder completion status
  Future<bool> toggleReminderCompletion(String id) async {
    try {
      final reminders = await getReminders();
      final reminder = reminders.firstWhere((r) => r.id == id);

      final updatedReminder = ReminderModel(
        id: reminder.id,
        title: reminder.title,
        description: reminder.description,
        dateTime: reminder.dateTime,
        isCompleted: !reminder.isCompleted,
        createdAt: reminder.createdAt,
      );

      return await updateReminder(updatedReminder);
    } catch (e) {
      print('Error toggling reminder completion: $e');
      return false;
    }
  }

  // Get reminders for a specific date
  Future<List<ReminderModel>> getRemindersForDate(DateTime date) async {
    try {
      final reminders = await getReminders();
      return reminders.where((reminder) {
        final reminderDate = DateTime(
          reminder.dateTime.year,
          reminder.dateTime.month,
          reminder.dateTime.day,
        );
        final targetDate = DateTime(
          date.year,
          date.month,
          date.day,
        );
        return reminderDate.isAtSameMomentAs(targetDate);
      }).toList();
    } catch (e) {
      print('Error getting reminders for date: $e');
      return [];
    }
  }

  // Initialize with sample data if no reminders exist
  Future<void> initializeWithSampleData() async {
    try {
      final reminders = await getReminders();
      if (reminders.isEmpty) {
        final sampleReminders = ReminderRepository.getSampleReminders();
        for (final reminder in sampleReminders) {
          await addReminder(reminder);
        }
      }
    } catch (e) {
      print('Error initializing sample data: $e');
    }
  }
}
