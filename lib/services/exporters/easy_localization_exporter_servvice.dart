import 'package:get/get.dart';

import '../../models/json/data.dart';
import '../../widgets/notification.dart';
import '../storage_service.dart';

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
      showNotification('Error Exporting', e.toString());
    }
  }
}
