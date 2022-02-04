import 'package:get/get.dart';
import '../storage_service.dart';

import '../../helpers/constants.dart';
import '../../models/json/data.dart';

class EasyLocalizationExporterService {
  final JsonData data;
  EasyLocalizationExporterService({required this.data});

  void export(String toFolder) {
    try {
      final storage = Get.find<StorageService>();
      for (var lan in data.data) {
        storage.writeFile('$toFolder/${lan.name}.json', lan.toJson());
      }
    } catch (e) {
      showError('Error Exporting', e.toString());
    }
  }
}
