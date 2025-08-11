import 'package:contacts_app/core/router/routes.dart';
import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:contacts_app/feature/auth/data/auth_service.dart';
import 'package:contacts_app/feature/profile/presentation/widgets/profile_info_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  bool _isResettingPassword = false;

  @override
  Widget build(BuildContext context) {
    final user = authService.value.currentUser;

    if (user == null) {
      Future.microtask(() => context.go(RoutePaths.welcome));
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(user),
              32.verticalSpace,
              _buildProfileInfo(user),
              32.verticalSpace,
              _buildMenuItems(user),
              32.verticalSpace,
              _buildLogoutButton(),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(User user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blue,
            AppColors.blue.withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 24.sp,
              ),
              8.horizontalSpace,
              Text(
                'Profile',
                style: AppFonts.bold24(color: Colors.white),
              ),
            ],
          ),
          24.verticalSpace,
          _buildProfileAvatar(user),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar(User user) {
    return Column(
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.2),
                Colors.white.withValues(alpha: 0.1),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 3,
            ),
          ),
          child: Center(
            child: Text(
              _getInitials(user.displayName ?? user.email ?? 'U'),
              style: AppFonts.bold30(
                color: Colors.white,
                font: AppFontFamily.poppins,
              ),
            ),
          ),
        ),
        16.verticalSpace,
        Text(
          user.displayName ?? 'User',
          style: AppFonts.bold20(color: Colors.white),
        ),
        4.verticalSpace,
        Text(
          user.email ?? '',
          style: AppFonts.regular14(color: Colors.white.withValues(alpha: 0.8)),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(User user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          ProfileInfoCard(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: user.email ?? 'Not provided',
          ),
          16.verticalSpace,
          ProfileInfoCard(
            icon: Icons.verified_outlined,
            title: 'Account Status',
            subtitle: user.emailVerified ? 'Verified' : 'Not verified',
            trailing: user.emailVerified
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20.sp,
                  )
                : Icon(
                    Icons.warning_amber,
                    color: Colors.orange,
                    size: 20.sp,
                  ),
          ),
          16.verticalSpace,
          ProfileInfoCard(
            icon: Icons.access_time_outlined,
            title: 'Member Since',
            subtitle: _formatDate(user.metadata.creationTime),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(User user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.lock_reset_outlined,
            title: 'Reset Password',
            subtitle: 'Send password reset link to your email',
            onTap: () => _handleResetPassword(user.email ?? ''),
            isLoading: _isResettingPassword,
          ),
          12.verticalSpace,
          _buildMenuItem(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage your notification preferences',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Notifications feature coming soon!')),
              );
            },
          ),
          12.verticalSpace,
          _buildMenuItem(
            icon: Icons.security_outlined,
            title: 'Privacy & Security',
            subtitle: 'Manage your privacy settings',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy settings coming soon!')),
              );
            },
          ),
          12.verticalSpace,
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help and contact support',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help & support coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 16.w,
                          height: 16.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        )
                      : Icon(
                          icon,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppFonts.semibold16(color: AppColors.black),
                      ),
                      4.verticalSpace,
                      Text(
                        subtitle,
                        style: AppFonts.regular14(color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.grey,
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade400, Colors.red.shade600],
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isLoading ? null : _handleLogout,
            borderRadius: BorderRadius.circular(12.r),
            child: Center(
              child: _isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        8.horizontalSpace,
                        Text(
                          'Log Out',
                          style: AppFonts.semibold16(color: Colors.white),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _handleResetPassword(String email) async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email address is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isResettingPassword = true;
    });

    try {
      await authService.value.resetPassword(email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset link sent to your email'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isResettingPassword = false;
        });
      }
    }
  }

  Future<void> _handleLogout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await authService.value.logout();
      if (mounted) {
        context.go(RoutePaths.welcome);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
