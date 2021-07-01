import 'package:get/get.dart';
import '../../models/qlocal.dart';

class GoogleTranslatorService extends GetConnect {
  final String apiKey;
  GoogleTranslatorService(this.apiKey);

  Future<QlevarLocalItem> tranlate(QlevarLocalItem item, String from) async {
    try {
      for (var i = 0; i < item.values.length; i++) {
        final key = item.values.keys.elementAt(i);
        if (key == from || item.values.values.elementAt(i).isNotEmpty) {
          continue;
        }
        item.values[key] = await getTranlation(item.values[from]!, from, key);
      }
    } on Exception catch (e) {
      Get.defaultDialog(title: 'Error Tranlating', middleText: e.toString());
    }
    return item;
  }

  Future<String> getTranlation(String value, String from, String to) async {
    final request = await get(
        'https://translation.googleapis.com/language/translate/v2',
        query: {
          'key': apiKey,
          'q': value,
          'target': to,
          'source': from,
        });
    if (request.status.code != 200) {
      throw Exception(request.body['error']['message']);
    }
    final result = request.body["data"]!["translations"]![0]!["translatedText"];
    return result;
  }
}
