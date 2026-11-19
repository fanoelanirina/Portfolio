import 'package:flutter/material.dart';
import '../theme/app_palette.dart';
import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles(this.p);

  static const String fontFamily = 'Montserrat';

  final AppPalette p;

  TextStyle _m(
    double size, {
    FontWeight? weight,
    double? height,
    double? spacing,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: spacing,
      color: color ?? p.textPrimary,
    );
  }

  TextStyle get greeting => _m(16, spacing: 1.6);
  TextStyle name(double size) => _m(size, weight: FontWeight.w500, height: 1.15);
  TextStyle role(double size) => _m(size);
  TextStyle get button => _m(14, weight: FontWeight.w600, spacing: 0.3);
  TextStyle get contact => _m(13, color: p.textSecondary);
  TextStyle get menuItem => _m(22, weight: FontWeight.w500);
  TextStyle get menuNumber => _m(12, spacing: 1.2, color: p.textSecondary);
  TextStyle get sectionLabel =>
      _m(13, spacing: 2, weight: FontWeight.w600, color: AppColors.accent);
  TextStyle sectionHeadline(double size) =>
      _m(size, weight: FontWeight.w600, height: 1.25);
  TextStyle get body => _m(15, height: 1.7, color: p.textSecondary);
  TextStyle get cardTitle => _m(16, weight: FontWeight.w600);
  TextStyle get cardSubtitle => _m(13, height: 1.5, color: p.textSecondary);
  TextStyle get chip => _m(13);
  TextStyle get blockTitle => _m(20, weight: FontWeight.w600);
  TextStyle get cardOrg =>
      _m(13, weight: FontWeight.w600, color: AppColors.accent);
  TextStyle get quote => _m(17, weight: FontWeight.w500, height: 1.5);
  TextStyle get tag =>
      _m(11, spacing: 1.4, weight: FontWeight.w600, color: AppColors.accent);
}

extension AppTextContext on BuildContext {
  AppTextStyles get text => AppTextStyles(palette);
}
