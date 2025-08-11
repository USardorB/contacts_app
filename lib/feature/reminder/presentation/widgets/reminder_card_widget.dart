import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReminderCardWidget extends StatelessWidget {
  const ReminderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84.h,
      margin: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.borderColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_none_outlined,
                size: 30.sp,
              ),
              10.horizontalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Call David",
                      style: AppFonts.regular18(
                          font: AppFontFamily.poppins, color: AppColors.black)),
                  Text("Today at 5:00 pm",
                      style: AppFonts.regular12(
                          font: AppFontFamily.poppins,
                          color: AppColors.black.withValues(alpha: 0.5))),
                ],
              ),
            ],
          ),
          Text("✓ Done",
              style: AppFonts.regular12(
                  font: AppFontFamily.poppins, color: AppColors.black)),
        ],
      ),
    );
  }
}
