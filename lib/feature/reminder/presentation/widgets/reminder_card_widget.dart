import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:contacts_app/data/models/reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReminderCardWidget extends StatelessWidget {
  final ReminderModel reminder;
  final VoidCallback? onToggleCompletion;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const ReminderCardWidget({
    super.key,
    required this.reminder,
    this.onToggleCompletion,
    this.onDelete,
    this.onEdit,
  });

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final reminderDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (reminderDate.isAtSameMomentAs(today)) {
      return 'Today at ${DateFormat('h:mm a').format(dateTime)}';
    } else if (reminderDate.isAtSameMomentAs(today.add(Duration(days: 1)))) {
      return 'Tomorrow at ${DateFormat('h:mm a').format(dateTime)}';
    } else {
      return DateFormat('MMM d, yyyy at h:mm a').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84.h,
      margin: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: reminder.isCompleted
            ? AppColors.borderColor.withValues(alpha: 0.1)
            : AppColors.borderColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: reminder.isCompleted
              ? AppColors.borderColor.withValues(alpha: 0.5)
              : AppColors.borderColor,
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: onToggleCompletion,
                  child: Icon(
                    reminder.isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    size: 30.sp,
                    color: reminder.isCompleted
                        ? Colors.green
                        : AppColors.borderColor,
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminder.title,
                        style: AppFonts.regular18(
                          font: AppFontFamily.poppins,
                          color: reminder.isCompleted
                              ? AppColors.black.withValues(alpha: 0.6)
                              : AppColors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (reminder.description.isNotEmpty)
                        Text(
                          reminder.description,
                          style: AppFonts.regular12(
                            font: AppFontFamily.poppins,
                            color: AppColors.black.withValues(alpha: 0.5),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      Text(
                        _formatDateTime(reminder.dateTime),
                        style: AppFonts.regular12(
                          font: AppFontFamily.poppins,
                          color: reminder.isCompleted
                              ? AppColors.black.withValues(alpha: 0.4)
                              : AppColors.black.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit,
                    size: 20.sp,
                    color: AppColors.borderColor,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    minWidth: 32.w,
                    minHeight: 32.h,
                  ),
                ),
              if (onDelete != null)
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20.sp,
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    minWidth: 32.w,
                    minHeight: 32.h,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
