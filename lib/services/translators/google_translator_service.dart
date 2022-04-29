import 'package:get/get.dart';

import '../../models/qlocal.dart';
import '../../widgets/notification.dart';

class GoogleTranslatorService extends GetConnect {
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
    final request = await get(
        'https://translation.googleapis.com/language/translate/v2',
        query: {
          'key': apiKey,
          'q': value,
          'target': to.substring(0, 2),
          'source': from.substring(0, 2),
        });
    if (request.status.code != 200) {
      throw Exception(request.bodyString);
    }
    final result = request.body["data"]!["translations"]![0]!["translatedText"];
    return result;
  }
}
