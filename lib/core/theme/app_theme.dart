import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_palette.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => _build(Brightness.dark, AppPalette.dark);
  static ThemeData get light => _build(Brightness.light, AppPalette.light);

  static ThemeData _build(Brightness brightness, AppPalette palette) {
    final base = ThemeData(useMaterial3: true, brightness: brightness);
    return base.copyWith(
      scaffoldBackgroundColor: palette.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: brightness,
      ).copyWith(primary: AppColors.accent, surface: palette.surface),
      textTheme: base.textTheme.apply(
        fontFamily: 'Montserrat',
        bodyColor: palette.textPrimary,
        displayColor: palette.textPrimary,
      ),
      extensions: [palette],
    );
  }
}
