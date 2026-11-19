import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/app.dart';
import 'package:portfolio/core/settings/app_settings.dart';
import 'package:visibility_detector/visibility_detector.dart';

Widget createApp() => PortfolioApp(settings: AppSettings());

void main() {
  setUpAll(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('drawer highlights the section currently in view', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));

    Future<void> expectActiveItem(String label) async {
      scaffold.openDrawer();
      await tester.pumpAndSettle();

      final item = find.descendant(
        of: find.byType(Drawer),
        matching: find.text(label),
      );
      expect(tester.widget<Text>(item).style?.color, AppColors.accent);

      scaffold.closeDrawer();
      await tester.pumpAndSettle();
    }

    await expectActiveItem('Accueil');

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -700),
    );
    await tester.pumpAndSettle();

    await expectActiveItem('À propos');
  });

  testWidgets('selecting Accueil from À propos returns to the top', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -700),
    );
    await tester.pumpAndSettle();

    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Accueil'));
    await tester.pumpAndSettle();

    final scrollView = tester.widget<SingleChildScrollView>(
      find.byType(SingleChildScrollView),
    );
    expect(scrollView.controller!.offset, 0);

    scaffold.openDrawer();
    await tester.pumpAndSettle();
    final homeItem = find.descendant(
      of: find.byType(Drawer),
      matching: find.text('Accueil'),
    );
    expect(tester.widget<Text>(homeItem).style?.color, AppColors.accent);
  });

  testWidgets('selecting Compétences scrolls to and activates that section', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Compétences'));
    await tester.pumpAndSettle();

    expect(find.text('Flutter & Dart'), findsOneWidget);
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    final skillsItem = find.descendant(
      of: find.byType(Drawer),
      matching: find.text('Compétences'),
    );
    expect(tester.widget<Text>(skillsItem).style?.color, AppColors.accent);
  });

  testWidgets('selecting Projets scrolls to and activates that section', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Projets'));
    await tester.pumpAndSettle();

    expect(find.text('AI-Dance-Coach'), findsOneWidget);
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    final projectsItem = find.descendant(
      of: find.byType(Drawer),
      matching: find.text('Projets'),
    );
    expect(tester.widget<Text>(projectsItem).style?.color, AppColors.accent);
  });

  testWidgets('selecting Contact scrolls to and activates that section', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Contact'));
    await tester.pumpAndSettle();

    expect(find.text('Envoyer un message'), findsOneWidget);
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    final contactItem = find.descendant(
      of: find.byType(Drawer),
      matching: find.text('Contact'),
    );
    expect(tester.widget<Text>(contactItem).style?.color, AppColors.accent);
  });

  testWidgets('hero contact button scrolls to Contact', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Me contacter'));
    await tester.pumpAndSettle();

    expect(find.text('Envoyer un message'), findsOneWidget);
    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffold.openDrawer();
    await tester.pumpAndSettle();

    final contactItem = find.descendant(
      of: find.byType(Drawer),
      matching: find.text('Contact'),
    );
    expect(tester.widget<Text>(contactItem).style?.color, AppColors.accent);
  });
}
