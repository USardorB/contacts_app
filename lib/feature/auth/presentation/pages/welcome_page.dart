import 'package:contacts_app/core/constants/app_images.dart';
import 'package:contacts_app/core/router/routes.dart';
import 'package:contacts_app/core/services/app_init_service.dart';
import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:contacts_app/core/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _handleJoinNow(BuildContext context) async {
    // Set welcome page as seen
    await AppInitService.setHasSeenWelcomePage();

    // Navigate to login page
    if (context.mounted) {
      context.push(RoutePaths.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.welcome),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    AppImages.girl1,
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
                20.verticalSpace,
                Image.asset(AppImages.girl2, width: 160.w, height: 160.h),
                const Spacer(flex: 1),
                Text(
                  "Let's Get Started",
                  style: AppFonts.heavy72(color: AppColors.black, height: 0.8),
                ),
                40.verticalSpace,
                AppPrimaryButton(
                  title: 'JOIN NOW',
                  onPressed: () => _handleJoinNow(context),
                  height: 62.h,
                  isDisabled: false,
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
