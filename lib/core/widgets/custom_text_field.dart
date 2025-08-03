import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool obscureText;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppFonts.regular16(color: AppColors.black),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 20.sp, color: AppColors.grey)
                : null,
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 16.w,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black),
              borderRadius: BorderRadius.circular(12.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black),
              borderRadius: BorderRadius.circular(12.r),
            ),
            filled: true,
          ),
        ),
      ],
    );
  }
}
