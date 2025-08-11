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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    if (emailController.text.trim().isEmpty ||
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
      await authService.value.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

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

  void resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'Please enter your email address';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await authService.value.resetPassword(emailController.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Password reset email sent. Please check your inbox.',
            ),
            backgroundColor: AppColors.green,
          ),
        );
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
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 32.w, top: 24.h),
            child: Text(
              "Welcome Back!",
              style: AppFonts.bold30(color: AppColors.black),
            ),
          ),
          6.verticalSpace,
          Padding(
            padding: EdgeInsets.only(left: 32.w, bottom: 20.h),
            child: Text(
              "Enter Your Username & Password",
              style: AppFonts.regular14(color: AppColors.lightGrey),
            ),
          ),
          56.verticalSpace,
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.loginBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                child: Column(
                  children: [
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
                    SizedBox(height: 32.h),
                    AppPrimaryButton(
                      title: 'Log In',
                      onPressed: isLoading ? null : login,
                      isLoading: isLoading,
                    ),
                    SizedBox(height: 16.h),
                    if (errorMessage != null)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.red.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: AppFonts.regular14(color: AppColors.red),
                        ),
                      ),
                    SizedBox(height: 16.h),
                    Center(
                      child: GestureDetector(
                        onTap: isLoading ? null : resetPassword,
                        child: Text(
                          'Forgot Password?',
                          style: AppFonts.regular14(
                            color: isLoading
                                ? AppColors.grey
                                : AppColors.lightGrey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Center(
                      child: GestureDetector(
                        onTap: () => context.push(RoutePaths.singUp),
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: AppFonts.regular14(
                              color: AppColors.lightGrey,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: AppFonts.medium14(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
