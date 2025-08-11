import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:contacts_app/data/models/reminder_model.dart';
import 'package:contacts_app/feature/reminder/data/reminder_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _reminderService = ReminderService();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _saveReminder() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title for the reminder')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final dateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final reminder = ReminderModel.create(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        dateTime: dateTime,
      );

      final success = await _reminderService.addReminder(reminder);

      if (success) {
        if (mounted) {
          context.pop(true); // Return true to indicate success
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save reminder')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving reminder: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Reminder",
            style: AppFonts.regular20(
                font: AppFontFamily.poppins, color: AppColors.black)),
        leading: IconButton(
          icon: Icon(Icons.close, size: 24.sp),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: _isLoading
                ? SizedBox(
                    width: 20.sp,
                    height: 20.sp,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            onPressed: _isLoading ? null : _saveReminder,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Field
            Text(
              "Title",
              style: AppFonts.semibold14(
                color: AppColors.black,
                font: AppFontFamily.poppins,
              ),
            ),
            8.verticalSpace,
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter reminder title',
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            24.verticalSpace,

            // Description Field
            Text(
              "Description (Optional)",
              style: AppFonts.semibold14(
                color: AppColors.black,
                font: AppFontFamily.poppins,
              ),
            ),
            8.verticalSpace,
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter reminder description',
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            24.verticalSpace,

            // Date and Time Section
            Text(
              "Date & Time",
              style: AppFonts.semibold14(
                color: AppColors.black,
                font: AppFontFamily.poppins,
              ),
            ),
            16.verticalSpace,

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.grey.shade600),
                          10.horizontalSpace,
                          Text(
                            DateFormat('MMM dd, yyyy').format(_selectedDate),
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: GestureDetector(
                    onTap: _selectTime,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey.shade600),
                          10.horizontalSpace,
                          Text(
                            _selectedTime.format(context),
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Preview Section
            if (_titleController.text.isNotEmpty) ...[
              32.verticalSpace,
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.borderColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: AppColors.borderColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preview",
                      style: AppFonts.semibold14(
                        color: AppColors.black,
                        font: AppFontFamily.poppins,
                      ),
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_none_outlined,
                          size: 24.sp,
                          color: AppColors.borderColor,
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _titleController.text,
                                style: AppFonts.regular16(
                                  font: AppFontFamily.poppins,
                                  color: AppColors.black,
                                ),
                              ),
                              if (_descriptionController.text.isNotEmpty)
                                Text(
                                  _descriptionController.text,
                                  style: AppFonts.regular14(
                                    font: AppFontFamily.poppins,
                                    color:
                                        AppColors.black.withValues(alpha: 0.7),
                                  ),
                                ),
                              Text(
                                DateFormat('MMM dd, yyyy at h:mm a').format(
                                  DateTime(
                                    _selectedDate.year,
                                    _selectedDate.month,
                                    _selectedDate.day,
                                    _selectedTime.hour,
                                    _selectedTime.minute,
                                  ),
                                ),
                                style: AppFonts.regular12(
                                  font: AppFontFamily.poppins,
                                  color: AppColors.black.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
