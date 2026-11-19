import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { fr, en }

class AppSettings extends ChangeNotifier {
  AppSettings({
    this.language = AppLanguage.fr,
    this.themeMode = ThemeMode.dark,
  });

  AppLanguage language;
  ThemeMode themeMode;

  bool get isFr => language == AppLanguage.fr;
  bool get isDark => themeMode == ThemeMode.dark;

  static Future<AppSettings> load() async {
    final preferences = await SharedPreferences.getInstance();
    return AppSettings(
      language: preferences.getString('language') == 'en'
          ? AppLanguage.en
          : AppLanguage.fr,
      themeMode: preferences.getString('theme') == 'light'
          ? ThemeMode.light
          : ThemeMode.dark,
    );
  }

  Future<void> setLanguage(AppLanguage value) async {
    if (value == language) return;
    language = value;
    notifyListeners();
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('language', value.name);
  }

  Future<void> setThemeMode(ThemeMode value) async {
    if (value == themeMode) return;
    themeMode = value;
    notifyListeners();
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('theme', isDark ? 'dark' : 'light');
  }
}

class AppSettingsScope extends InheritedNotifier<AppSettings> {
  const AppSettingsScope({
    super.key,
    required AppSettings settings,
    required super.child,
  }) : super(notifier: settings);

  static AppSettings of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppSettingsScope>();
    assert(scope != null, 'AppSettingsScope introuvable');
    return scope!.notifier!;
  }
}

extension AppSettingsContext on BuildContext {
  AppSettings get settings => AppSettingsScope.of(this);
  bool get isFr => settings.isFr;

  String tr(String fr, String en) => isFr ? fr : en;
}
