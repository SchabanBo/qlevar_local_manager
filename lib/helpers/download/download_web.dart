import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

void downloadFile(String downloadName, String data) {
  final rawData = utf8.encode(data);
  final _base64 = base64Encode(rawData);
  final anchor =
      AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
        ..target = 'blank';
  anchor.download = downloadName;
  document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}
