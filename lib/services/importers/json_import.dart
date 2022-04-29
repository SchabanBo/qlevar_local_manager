import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../models/json/data.dart';
import '../../pages/main/controllers/main_controller.dart';
import '../../widgets/notification.dart';
import '../storage_service.dart';

class JsonFileImporter {
  Future<void> import(String file, String lan) async {
    if (!kIsWeb) {
      final data = await Get.find<StorageService>().readFile(file);
      if (data == null) {
        showNotification('File not found', 'File not found');
        return;
      }
      file = data;
    }

    importData(file, lan);
  }

  Future<void> importData(String data, String lan) async {
    final locals = Get.find<MainController>().locals;
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
