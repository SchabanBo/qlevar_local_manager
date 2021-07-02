import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/colors.dart';
import '../controller.dart';
import '../../../helpers/path_picker.dart';

class ExportView extends StatelessWidget {
  final ExportController controller = ExportController();
  ExportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Export Data', style: TextStyle(fontSize: 24)),
            const Divider(),
            Obx(() => Row(
                  children: ExportAs.values
                      .map((e) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<ExportAs>(
                                activeColor: AppColors.primary,
                                value: e,
                                groupValue: controller.exportAs(),
                                onChanged: controller.exportAs,
                              ),
                              Text(describeEnum(e)),
                            ],
                          ))
                      .toList(),
                )),
            PathPicker(
                path: controller.path(),
                title: 'Give the directory path to export to',
                onChange: controller.path),
            const Spacer(),
            ElevatedButton(
                onPressed: controller.export, child: const Text('Export')),
          ],
        ),
      ),
    );
  }
}
