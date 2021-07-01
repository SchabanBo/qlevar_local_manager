import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_page/controllers/main_controller.dart';
import 'export_view.dart';

class ExportIcon extends StatelessWidget {
  const ExportIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.bottomSheet(
          ExportView(path: Get.find<MainController>().appfile.exportPath)),
      icon: const Icon(Icons.import_export),
      tooltip: 'Export Data',
    );
  }
}
