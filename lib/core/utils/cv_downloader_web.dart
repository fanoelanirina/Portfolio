import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

bool downloadCv(Uint8List bytes, String fileName) {
  final body = html.document.body;
  if (body == null) return false;

  final blob = html.Blob(<Object>[bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..download = fileName
    ..style.display = 'none';

  body.append(anchor);
  anchor.click();
  anchor.remove();
  unawaited(
    Future<void>.delayed(
      const Duration(seconds: 1),
      () => html.Url.revokeObjectUrl(url),
    ),
  );
  return true;
}
