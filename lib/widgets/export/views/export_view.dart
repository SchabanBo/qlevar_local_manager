import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../../helpers/path_picker.dart';
import '../controllers/export_controller.dart';

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
          Observer(
              builder: (_) => Column(
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
                  path: controller.path.value,
                  title: 'Give the directory path to export to',
                  onChange: controller.path),
          const SizedBox(height: 8),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.export();
              Navigator.pop(context);
            },
            child: const Text('Export')),
      ],
    );
  }
}
