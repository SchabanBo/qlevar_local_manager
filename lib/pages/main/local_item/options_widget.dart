import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:q_overlay/q_overlay.dart';

import '../../../helpers/constants.dart';
import '../../../models/qlocal.dart';
import '../../../services/translators/google_translator_service.dart';
import '../../../widgets/notification.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/item_controller.dart';
import '../controllers/main_controller.dart';

class OptionsWidget extends StatelessWidget {
  final LocalItemController controller;
  const OptionsWidget({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => options;

  Widget get options => Row(
        children: [
          InkWell(
            child: const Tooltip(
                message: 'Copy Path',
                child: Icon(
                  Icons.copy,
                  color: AppColors.icon,
                )),
            onTap: copyPath,
          ),
          const SizedBox(width: 5),
          InkWell(
            child: const Tooltip(
                message: 'Translate',
                child: Icon(
                  Icons.translate,
                  color: AppColors.icon,
                )),
            onTap: translate,
          ),
          const SizedBox(width: 5),
          InkWell(
              child: const Tooltip(
                  message: 'Delete',
                  child: Icon(
                    Icons.delete_outline,
                    color: AppColors.icon,
                  )),
              onTap: () => QDialog(
                      child: SizedBox(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              'Are you sure you want to delete ${controller.item.name}?'),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Spacer(),
                              TextButton(
                                  onPressed: QOverlay.dismissLast,
                                  child: const Text('No')),
                              const SizedBox(width: 8),
                              TextButton(
                                  onPressed: () {
                                    Get.find<MainController>()
                                        .removeItem(controller.indexMap);
                                    QOverlay.dismissLast();
                                  },
                                  child: const Text('Yes')),
                            ],
                          )
                        ],
                      ),
                    ),
                  )).show()),
        ],
      );

  void translate() async {
    final languages = Get.find<MainController>().locals().languages;
    final lan = await QDialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Translate from :',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            ...languages
                .map((e) => TextButton(
                      onPressed: () => QOverlay.dismissLast(result: e),
                      child: Text(e),
                    ))
                .toList()
          ],
        ),
      ),
    ).show<String>();
    if (lan == null) return;
    final settings = Get.find<SettingsController>().settings().tranlation;
    if (settings.googleApi.isEmpty) {
      showNotification('api key is missing',
          'Google api key is empty, please set it first in the settings');
      return;
    }
    final serivce = GoogleTranslatorService(settings.googleApi);
    await serivce.translate(controller.item, lan);
    Get.find<MainController>().locals.refresh();
  }

  void copyPath() {
    final indexMap = controller.indexMap;
    var result = '';
    LocalNode node = Get.find<MainController>().locals();

    for (var i = 1; i < indexMap.length - 1; i++) {
      node = node.children
          .whereType<LocalNode>()
          .firstWhere((e) => e.hashCode == indexMap[i]);
      result += node.name + '_';
    }
    final item = node.children.firstWhere((e) => e.hashCode == indexMap.last);
    result += item.name;
    Clipboard.setData(ClipboardData(text: result));
  }
}
