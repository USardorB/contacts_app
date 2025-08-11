import 'package:contacts_app/core/router/routes.dart';
import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:contacts_app/feature/home/data/models/reminder_model.dart';
import 'package:contacts_app/feature/reminder/data/reminder_service.dart';
import 'package:contacts_app/feature/reminder/presentation/widgets/reminder_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final ReminderService _reminderService = ReminderService();
  List<ReminderModel> _reminders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeAndLoadReminders();
  }

  Future<void> _initializeAndLoadReminders() async {
    await _reminderService.initializeWithSampleData();
    await _loadReminders();
  }

  Future<void> _loadReminders() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final reminders = await _reminderService.getReminders();
      if (!mounted) return;
      setState(() {
        _reminders = reminders;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading reminders: $e')),
        );
      }
    }
  }

  Future<void> _deleteReminder(String id) async {
    final reminder = _reminders.firstWhere((r) => r.id == id);

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Reminder'),
        content: Text('Are you sure you want to delete "${reminder.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;

    try {
      final success = await _reminderService.deleteReminder(id);
      if (success) {
        await _loadReminders();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reminder deleted')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting reminder: $e')),
        );
      }
    }
  }

  void _editReminder(ReminderModel reminder) {
    // TODO: Implement edit functionality
    // For now, just show a snackbar
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit functionality coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
          ),
          padding:
              EdgeInsets.only(top: 60.h, right: 32.w, left: 32.w, bottom: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reminders",
                  style: AppFonts.regular20(
                      font: AppFontFamily.poppins, color: AppColors.black)),
              IconButton(
                onPressed: () async {
                  final result = await context.push(RoutePaths.addReminder);
                  if (result == true) {
                    _loadReminders();
                  }
                },
                icon: Icon(Icons.add, size: 24.sp),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _reminders.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_none_outlined,
                              size: 64.sp,
                              color:
                                  AppColors.borderColor.withValues(alpha: 0.5),
                            ),
                            16.verticalSpace,
                            Text(
                              'No reminders yet',
                              style: AppFonts.regular18(
                                font: AppFontFamily.poppins,
                                color: AppColors.black.withValues(alpha: 0.7),
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              'Tap the + button to add your first reminder',
                              style: AppFonts.regular14(
                                font: AppFontFamily.poppins,
                                color: AppColors.black.withValues(alpha: 0.5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadReminders,
                        child: ListView.builder(
                          itemCount: _reminders.length,
                          itemBuilder: (context, index) {
                            final reminder = _reminders[index];
                            return ReminderCardWidget(
                              reminder: reminder,
                              onDelete: () => _deleteReminder(reminder.id),
                              onEdit: () => _editReminder(reminder),
                            );
                          },
                        ),
                      ),
          ),
        ),
      ],
    );
  }
}
