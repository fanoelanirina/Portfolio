import 'package:flutter/material.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.borderStrong,
  });

  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color borderStrong;

  static const dark = AppPalette(
    background: Color(0xFF000000),
    surface: Color(0xFF111111),
    surfaceAlt: Color(0xFF1A1A1A),
    textPrimary: Colors.white,
    textSecondary: Color(0xFFB5B5B5),
    border: Color(0x1AFFFFFF),
    borderStrong: Color(0x3DFFFFFF),
  );

  static const light = AppPalette(
    background: Color(0xFFF7F6F3),
    surface: Color(0xFFFFFFFF),
    surfaceAlt: Color(0xFFF0EEEA),
    textPrimary: Color(0xFF111111),
    textSecondary: Color(0xFF5E5E5E),
    border: Color(0x1A000000),
    borderStrong: Color(0x33000000),
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? borderStrong,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
