import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/export_controller.dart';
import '../../../helpers/path_picker.dart';

class ExportView extends StatelessWidget {
  final ExportController controller = ExportController();
  ExportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Export Data', style: TextStyle(fontSize: 24)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Column(
                children: ExportAs.values
                    .map((e) => RadioListTile<ExportAs>(
                          title: Text(e.name),
                          value: e,
                          groupValue: controller.exportAs.value,
                          onChanged: (e) => controller.exportAs(e),
                        ))
                    .toList(),
              )),
          kIsWeb
              ? const SizedBox.shrink()
              : PathPicker(
                  path: controller.path(),
                  title: 'Give the directory path to export to',
                  onChange: controller.path),
          const SizedBox(height: 8),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.export();
              Get.back();
            },
            child: const Text('Export')),
      ],
    );
  }
}
