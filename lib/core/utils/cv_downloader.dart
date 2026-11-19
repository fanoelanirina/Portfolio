import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../constants/app_colors.dart';
import '../constants/app_urls.dart';
import '../settings/app_settings.dart';

class CvDownloader {
  CvDownloader._();

  static const String assetPath = AppUrls.cvAsset;
  static const String fileName = 'CV_Fanoela';

  static Future<void> download(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final isFr = context.isFr;

    try {
      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      if (kIsWeb) {
        await FileSaver.instance.saveFile(
          name: fileName,
          bytes: bytes,
          fileExtension: 'pdf',
          mimeType: MimeType.pdf,
        );
        _show(
          messenger,
          isFr ? 'CV téléchargé !' : 'CV downloaded!',
          error: false,
        );
      } else {
        await FileSaver.instance.saveAs(
          name: fileName,
          bytes: bytes,
          fileExtension: 'pdf',
          mimeType: MimeType.pdf,
        );
      }
    } catch (_) {
      _show(
        messenger,
        isFr
            ? 'Impossible de télécharger le CV. Réessayez plus tard.'
            : 'Could not download the CV. Please try again later.',
        error: true,
      );
    }
  }

  static void _show(
    ScaffoldMessengerState messenger,
    String message, {
    required bool error,
  }) {
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          backgroundColor: error ? Colors.redAccent : AppColors.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
