import 'package:contacts_app/core/router/routes.dart';
import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:contacts_app/feature/reminder/presentation/widgets/reminder_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

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
                onPressed: () {
                  context.push(RoutePaths.addReminder);
                },
                icon: Icon(Icons.add, size: 24.sp),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return ReminderCardWidget();
              },
            ),
          ),
        ),
      ],
    );
  }
}
