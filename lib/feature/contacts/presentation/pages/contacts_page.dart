import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:contacts_app/feature/auth/data/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  void _handleLogout(BuildContext context) async {
    try {
      await authService.value.logout();
      if (context.mounted) {
        context.go('/welcome');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error logging out: ${e.toString()}'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _handleLogout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: AppFonts.bold20(color: AppColors.black),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    user?.displayName ?? user?.email ?? 'User',
                    style: AppFonts.regular16(color: AppColors.grey),
                  ),
                  if (user?.email != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      user!.email!,
                      style: AppFonts.regular14(color: AppColors.lightGrey),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Contacts section placeholder
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 80.sp,
                      color: AppColors.grey,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No contacts yet',
                      style: AppFonts.bold20(color: AppColors.black),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Your contacts will appear here',
                      style: AppFonts.regular14(color: AppColors.lightGrey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add contact functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add contact functionality coming soon!'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
