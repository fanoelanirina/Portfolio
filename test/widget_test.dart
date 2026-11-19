import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:portfolio/core/settings/app_settings.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  test('language and theme preferences are restored after changes', () async {
    SharedPreferences.setMockInitialValues({});

    final settings = await AppSettings.load();
    expect(settings.language, AppLanguage.fr);
    expect(settings.themeMode, ThemeMode.dark);

    await settings.setLanguage(AppLanguage.en);
    await settings.setThemeMode(ThemeMode.light);

    final restored = await AppSettings.load();
    expect(restored.language, AppLanguage.en);
    expect(restored.themeMode, ThemeMode.light);
  });

  testWidgets('drawer controls switch language and theme', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    final settings = AppSettings();
    await tester.pumpWidget(PortfolioApp(settings: settings));

    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Changer la langue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('HELLO!'), findsOneWidget);

    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );
    expect(settings.language, AppLanguage.en);
    expect(settings.themeMode, ThemeMode.light);
  });
}
