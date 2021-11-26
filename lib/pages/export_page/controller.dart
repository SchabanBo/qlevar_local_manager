import 'package:get/get.dart';
import '../../services/exporters/easy_localization_exporter_servvice.dart';
import '../main_page/controllers/main_controller.dart';
import '../../services/exporters/getx_exporter_servvice.dart';

class ExportController extends GetxController {
  final RxString path = Get.find<MainController>().appfile.exportPath.obs;
  final Rx<ExportAs> exportAs = ExportAs.getx.obs;

  void export() {
    final mainCon = Get.find<MainController>();
    mainCon.loading.value = true;
    final data = mainCon.locals().toData();
    switch (exportAs()) {
      case ExportAs.getx:
        GetxExporterService(data: data).export(path() + '/locals.g.dart');
        break;
      case ExportAs.easyLocalization:
        EasyLocalizationExporterService(data: data).export(path());
        break;
    }

    mainCon.loading.value = false;
  }
}

enum ExportAs {
  easyLocalization,
  getx,
}
