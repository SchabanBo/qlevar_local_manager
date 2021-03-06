import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_overlay/q_overlay.dart';

import '../controllers/language_controller.dart';
import 'language_dialog.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Languages', style: TextStyle(fontSize: 20)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_box, color: Colors.green),
                  onPressed: _addLanguage,
                ),
              ],
            ),
            const Divider(),
            Expanded(
                child: Obx(() => ListView(
                      shrinkWrap: true,
                      children: [
                        for (final language
                            in controller.main.locals().languages)
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(language,
                                      style: const TextStyle(fontSize: 18)),
                                  const Spacer(),
                                  InkWell(
                                    child: const Icon(Icons.arrow_upward),
                                    onTap: () =>
                                        controller.moveLanguage(language, -1),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    child: const Icon(Icons.arrow_downward),
                                    onTap: () =>
                                        controller.moveLanguage(language, 1),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    child: const Icon(Icons.edit,
                                        color: Colors.amber),
                                    onTap: () => _editLanguage(language),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    child: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onTap: () =>
                                        _removeLanguage(context, language),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ))),
            ElevatedButton(
              child: const SizedBox(
                  width: double.infinity, child: Center(child: Text('Close'))),
              onPressed: () => QOverlay.dismissName('SetingsScreen'),
            ),
          ],
        ),
      );

  void _addLanguage() async {
    QDialog(child: LanguageDialog(), width: 200).show<String>().then((value) {
      if (value != null && value.isNotEmpty) {
        controller.addLanguage(value);
      }
    });
  }

  void _editLanguage(String language) {
    QDialog(child: LanguageDialog(value: language), width: 200)
        .show<String>()
        .then((value) {
      if (value != null && value.isNotEmpty) {
        controller.updateLanguage(language, value);
      }
    });
  }

  void _removeLanguage(BuildContext context, String language) {
    QDialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Are you sure you want to delete this language?'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: const Text('Yes'),
                          onPressed: () =>
                              QOverlay.dismissLast<bool>(result: true),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextButton(
                            child: const Text('No'),
                            onPressed: QOverlay.dismissLast),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            width: 200)
        .show<bool>()
        .then((value) {
      if (value ?? false) {
        controller.removeLanguage(language);
      }
    });
  }
}
