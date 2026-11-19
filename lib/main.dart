import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'app.dart';
import 'core/settings/app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  VisibilityDetectorController.instance.updateInterval =
      const Duration(milliseconds: 100);
  final settings = await AppSettings.load();
  runApp(PortfolioApp(settings: settings));
}
