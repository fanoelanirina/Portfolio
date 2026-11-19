import 'package:flutter/material.dart';
import 'core/settings/app_settings.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/screens/home_screen.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key, required this.settings});

  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    return AppSettingsScope(
      settings: settings,
      child: ListenableBuilder(
        listenable: settings,
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: settings.isFr
              ? 'Fanoela Rakotomalala | Développeur Flutter'
              : 'Fanoela Rakotomalala | Flutter Developer',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: settings.themeMode,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
