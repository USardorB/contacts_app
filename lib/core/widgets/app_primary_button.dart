import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final double? height;

  const AppPrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final bool clickable = !isDisabled && !isLoading;

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: height ?? 54.h,
        child: ElevatedButton(
          onPressed: clickable ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: clickable ? AppColors.black : AppColors.disabled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.r),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? SizedBox(
                  height: 20.r,
                  width: 20.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(title, style: AppFonts.regular36()),
        ),
      ),
    );
  }
}
