import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import '../../pages/main_page/controllers/main_controller.dart';
import '../../helpers/constants.dart';
import '../../models/json/data.dart';

class JsonFileImporter {
  Future<void> import(String file, String lan) async {
    final locals = Get.find<MainController>().locals;
    if (locals().languages.contains(lan)) {
      showError('Language already exist', 'Update not support yet');
    }
    final data = await File(file).readAsString();
    final node = JsonNode(lan);
    node.fromMap(jsonDecode(data) as Map<String, dynamic>);
    locals().languages.add(lan);
    for (var child in node.children) {
      if (child is JsonNode) {
        locals().addLocalNode(lan, child);
      } else if (child is JsonItem) {
        locals().addLocalItem(lan, child);
      }
    }
    locals.refresh();
  }
}
