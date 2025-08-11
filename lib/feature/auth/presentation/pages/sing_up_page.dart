import 'package:contacts_app/core/constants/app_images.dart';
import 'package:contacts_app/core/router/routes.dart';
import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:contacts_app/core/widgets/app_primary_button.dart';
import 'package:contacts_app/core/widgets/custom_text_field.dart';
import 'package:contacts_app/feature/auth/data/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await authService.value.signUp(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Clear form
      nameController.clear();
      emailController.clear();
      passwordController.clear();

      if (mounted) {
        context.go(RoutePaths.home);
      }
    } on AuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'An unexpected error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.signUpBg),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account :)',
                  style: AppFonts.bold30(color: AppColors.black),
                ),
                8.verticalSpace,
                Text(
                  'Please fill in the details below',
                  style: AppFonts.regular14(color: AppColors.lightGrey),
                ),
                32.verticalSpace,
                CustomTextField(
                  hint: 'Enter your full name',
                  controller: nameController,
                ),
                16.verticalSpace,
                CustomTextField(
                  hint: 'Enter your email',
                  controller: emailController,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  hint: 'Enter your password',
                  controller: passwordController,
                  obscureText: true,
                ),
                200.verticalSpace,
                AppPrimaryButton(
                  title: 'Sign Up',
                  onPressed: isLoading ? null : signUp,
                  isLoading: isLoading,
                ),
                16.verticalSpace,
                if (errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                          color: AppColors.red.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: AppFonts.regular14(color: AppColors.red),
                    ),
                  ),
                16.verticalSpace,
                Center(
                  child: GestureDetector(
                    onTap: () => context.push('/login'),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppFonts.regular14(color: AppColors.lightGrey),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: AppFonts.medium14(color: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
