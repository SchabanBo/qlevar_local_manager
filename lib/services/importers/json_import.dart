import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import '../../pages/main_page/controllers/main_controller.dart';
import '../../helpers/constants.dart';
import '../../models/local_data.dart';

class JsonFileImporter {
  Future<void> import(String file, String lan) async {
    final locals = Get.find<MainController>().locals;
    if (locals().languages.contains(lan)) {
      showError('Language already exist', 'Update not support yet');
    }
    final data = await File(file).readAsString();
    final node = LocalNode(lan);
    node.fromMap(jsonDecode(data) as Map<String, dynamic>);
    locals().languages.add(lan);
    for (var item in node.nodes) {
      locals().addLocalObject(lan, item);
    }
    for (var item in node.items) {
      locals().addLocalNode(lan, item);
    }
    locals.refresh();
  }
}
