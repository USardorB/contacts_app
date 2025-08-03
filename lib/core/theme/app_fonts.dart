import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppFontFamily {
  inter,
  roboto,
  lato,
  montserrat,
  poppins,
  openSans,
  nunito,
  k2d,
  kumbhSans,
  kronaOne,
  inder,
}

extension AppFontFamilyExtension on AppFontFamily {
  String get name {
    switch (this) {
      case AppFontFamily.inter:
        return 'Inter';
      case AppFontFamily.roboto:
        return 'Roboto';
      case AppFontFamily.lato:
        return 'Lato';
      case AppFontFamily.montserrat:
        return 'Montserrat';
      case AppFontFamily.poppins:
        return 'Poppins';
      case AppFontFamily.openSans:
        return 'Open Sans';
      case AppFontFamily.nunito:
        return 'Nunito';
      case AppFontFamily.k2d:
        return 'K2D';
      case AppFontFamily.kumbhSans:
        return 'Kumbh Sans';
      case AppFontFamily.kronaOne:
        return 'Krona One';
      case AppFontFamily.inder:
        return 'Inder';
    }
  }
}

abstract class AppFonts {
  // Light fonts
  static TextStyle light10({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 10.sp,
    color: color,
    height: height,
  );

  static TextStyle light12({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 12.sp,
    color: color,
    height: height,
  );

  static TextStyle light14({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 14.sp,
    color: color,
    height: height,
  );

  static TextStyle light16({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 16.sp,
    color: color,
    height: height,
  );

  static TextStyle light18({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 18.sp,
    color: color,
    height: height,
  );

  static TextStyle light20({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 20.sp,
    color: color,
    height: height,
  );

  static TextStyle light22({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 22.sp,
    color: color,
    height: height,
  );

  static TextStyle light24({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 24.sp,
    color: color,
    height: height,
  );

  static TextStyle light26({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 26.sp,
    color: color,
    height: height,
  );

  static TextStyle light28({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w300,
    fontSize: 28.sp,
    color: color,
    height: height,
  );
  static TextStyle regular36({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 36.sp,
    color: color,
    height: height,
  );

  // Regular fonts
  static TextStyle regular10({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 10.sp,
    color: color,
    height: height,
  );

  static TextStyle regular12({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
    TextDecoration? decoration,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: color,
    height: height,
    decoration: decoration,
  );

  static TextStyle regular14({
    Color color = AppColors.white,
    double? height,
    TextDecoration? textDecoration,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: color,
    height: height,
    decoration: textDecoration,
  );

  static TextStyle regular16({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
    Color? decorationColor,
    TextDecoration? decoration,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: color,
    height: height,
    decorationColor: decorationColor,
    decoration: decoration,
  );

  static TextStyle regular18({
    Color color = AppColors.white,
    double? height,
    TextDecoration? textDecoration,
    AppFontFamily font = AppFontFamily.inter,
    Color? decorationColor,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    color: color,
    height: height,
    decoration: textDecoration,
  );

  static TextStyle regular20({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
    color: color,
    height: height,
  );

  static TextStyle regular22({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 22.sp,
    color: color,
    height: height,
  );

  static TextStyle regular24({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 24.sp,
    color: color,
    height: height,
  );

  static TextStyle regular26({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 26.sp,
    color: color,
    height: height,
  );

  static TextStyle regular28({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 28.sp,
    color: color,
    height: height,
  );

  static TextStyle regular64({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w400,
    fontSize: 64.sp,
    color: color,
    height: height,
  );

  // Medium fonts
  static TextStyle medium12({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: color,
    height: height,
  );

  static TextStyle medium14({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: color,
    height: height,
  );

  static TextStyle medium16({
    Color color = AppColors.white,
    double? height,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: color,
    height: height,
    decoration: textDecoration,
    fontStyle: fontStyle,
  );

  static TextStyle medium18({
    Color color = AppColors.white,
    double? height,
    TextDecoration? textDecoration,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    color: color,
    height: height,
    decoration: textDecoration,
  );

  static TextStyle medium20({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
    color: color,
    height: height,
  );

  static TextStyle medium22({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 22.sp,
    color: color,
    height: height,
  );

  static TextStyle medium24({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 24.sp,
    color: color,
    height: height,
  );

  static TextStyle medium26({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 26.sp,
    color: color,
    height: height,
  );

  static TextStyle medium28({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 28.sp,
    color: color,
    height: height,
  );

  static TextStyle medium30({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 30.sp,
    color: color,
    height: height,
  );

  static TextStyle medium32({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w500,
    fontSize: 32.sp,
    color: color,
    height: height,
  );

  // Semibold fonts
  static TextStyle semibold10({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 10.sp,
    color: color,
    height: height,
  );
  static TextStyle semibold12({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    color: color,
    height: height,
  );

  static TextStyle semibold14({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    color: color,
    height: height,
  );

  static TextStyle semibold16({
    Color color = AppColors.white,
    double? height,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: color,
    height: height,
    decoration: decoration,
    fontStyle: fontStyle,
  );

  static TextStyle semibold18({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
    TextDecoration? decoration,
    Color? decorationColor,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    color: color,
    height: height,
    decoration: decoration,
    decorationColor: decorationColor,
  );

  static TextStyle semibold20({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    color: color,
    height: height,
  );

  static TextStyle semibold22({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 22.sp,
    color: color,
    height: height,
  );

  static TextStyle semibold24({
    Color color = AppColors.white,
    double? height,
    FontStyle? fontStyle,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 24.sp,
    color: color,
    height: height,
    fontStyle: fontStyle,
  );

  static TextStyle semibold26({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 26.sp,
    color: color,
    height: height,
  );

  static TextStyle semibold28({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 28.sp,
    color: color,
    height: height,
  );

  static TextStyle semibold30({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 30.sp,
    color: color,
    height: height,
  );

  static TextStyle semibold32({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 32.sp,
    color: color,
    height: height,
  );

  static TextStyle semibold40({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.poppins,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 40.sp,
    color: color,
    height: height,
  );

  static TextStyle semibold48({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.poppins,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w600,
    fontSize: 48.sp,
    color: color,
    height: height,
  );

  // Bold fonts
  static TextStyle bold12({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
    FontStyle? fontStyle,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
    color: color,
    height: height,
    fontStyle: fontStyle,
  );

  static TextStyle bold14({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
    color: color,
    height: height,
  );

  static TextStyle bold16({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
    FontStyle? fontStyle,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    color: color,
    fontStyle: fontStyle,
    height: height,
  );

  static TextStyle bold18({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
    color: color,
    height: height,
  );

  static TextStyle bold20({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
    color: color,
    height: height,
  );

  static TextStyle bold22({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 22.sp,
    color: color,
    height: height,
  );

  static TextStyle bold24({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 24.sp,
    color: color,
    height: height,
  );

  static TextStyle bold26({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 26.sp,
    color: color,
    height: height,
  );

  static TextStyle bold28({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 28.sp,
    color: color,
    height: height,
  );

  static TextStyle bold30({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
    color: color,
    height: height,
  );

  // Heavy fonts
  static TextStyle heavy12({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 12.sp,
    color: color,
    height: height,
  );

  static TextStyle heavy14({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 14.sp,
    color: color,
    height: height,
  );

  static TextStyle heavy16({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
    FontStyle? fontStyle,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 16.sp,
    color: color,
    height: height,
    fontStyle: fontStyle,
  );

  static TextStyle heavy18({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 18.sp,
    color: color,
    height: height,
  );

  static TextStyle heavy20({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 20.sp,
    color: color,
    height: height,
  );

  static TextStyle heavy22({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 22.sp,
    color: color,
    height: height,
  );

  static TextStyle heavy24({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
    FontStyle? fontStyle,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 24.sp,
    color: color,
    height: height,
    fontStyle: fontStyle,
  );

  static TextStyle heavy26({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 26.sp,
    color: color,
    height: height,
  );

  static TextStyle heavy28({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 28.sp,
    color: color,
    height: height,
  );
  static TextStyle heavy72({
    Color color = AppColors.white,
    double? height,
    AppFontFamily font = AppFontFamily.inter,
  }) => GoogleFonts.getFont(
    font.name,
    fontWeight: FontWeight.w800,
    fontSize: 72.sp,
    color: color,
    height: height,
  );
}
