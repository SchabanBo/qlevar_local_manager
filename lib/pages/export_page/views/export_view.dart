import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller.dart';
import '../../../helpers/path_picker.dart';

class ExportView extends StatelessWidget {
  final ExportController controller = ExportController();
  ExportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Get.theme.bottomAppBarColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Export Data', style: TextStyle(fontSize: 24)),
            const Divider(),
            Obx(() => ToggleButtons(
                children:
                    ExportAs.values.map((e) => Text(describeEnum(e))).toList(),
                onPressed: (i) => controller.exportAs(ExportAs.values[i]),
                isSelected: ExportAs.values
                    .map((e) => e == controller.exportAs())
                    .toList())),
            PathPicker(
                path: controller.path(),
                title: 'Give the directory path to export to',
                onChange: controller.path),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  controller.export();
                  Get.back();
                },
                child: const Text('Export')),
          ],
        ),
      ),
    );
  }
}
