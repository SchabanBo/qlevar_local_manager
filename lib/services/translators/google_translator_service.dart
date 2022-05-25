import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/qlocal.dart';
import '../../widgets/notification.dart';

class GoogleTranslatorService {
  final String apiKey;
  GoogleTranslatorService(this.apiKey);

  Future<LocalItem> translate(LocalItem item, String from) async {
    try {
      for (var i = 0; i < item.values.length; i++) {
        final key = item.values.keys.elementAt(i);
        if (key == from || item.values.values.elementAt(i).isNotEmpty) {
          continue;
        }
        item.values[key] = await getTranslation(item.values[from]!, from, key);
      }
    } on Exception catch (e) {
      showNotification('Error Translating', e.toString());
    }
    return item;
  }

  Future<String> getTranslation(String value, String from, String to) async {
    final url =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey&q=$value&source=$from&target=$to';
    final request = await http.get(Uri.parse(url));
    if (request.statusCode != 200) {
      throw Exception(request.body);
    }
    final result =
        jsonDecode(request.body)["data"]["translations"][0]["translatedText"];
    return result;
  }
}
