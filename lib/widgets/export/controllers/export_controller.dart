import 'package:get/get.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../../pages/main/controllers/main_controller.dart';
import '../../../services/exporters/easy_localization_exporter_service.dart';
import '../../../services/exporters/getx_exporter_service.dart';
import '../../notification.dart';

class ExportController extends GetxController {
  final Observable<String> path =
      Get.find<MainController>().appFile.exportPath.asObservable;
  final Observable<ExportAs> exportAs = ExportAs.getx.asObservable;

  void export() {
    final mainCon = Get.find<MainController>();
    mainCon.loading.value = true;
    final data = mainCon.locals.value.toData();
    switch (exportAs.value) {
      case ExportAs.getx:
        GetxExporterService(data: data).export('${path.value}/locals.g.dart');
        break;
      case ExportAs.easyLocalization:
        EasyLocalizationExporterService(data: data).export(path.value);
        break;
    }

    mainCon.loading.value = false;
    showNotification('Export Success', 'Locals exported successfully');
  }
}

enum ExportAs {
  easyLocalization,
  getx,
}
