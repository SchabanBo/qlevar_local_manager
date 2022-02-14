import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:q_overlay/q_overlay.dart';
import '../../../models/qlocal.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../../services/translators/google_translator_service.dart';
import '../../../helpers/constants.dart';
import '../controllers/main_controller.dart';
import '../controllers/item_controller.dart';

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
            onTap: () => Get.defaultDialog(
                title: 'Delete',
                middleText:
                    'Are you sure you want to delete ${controller.item.name}?',
                onConfirm: () {
                  Get.find<MainController>().removeItem(controller.indexMap);
                  Get.back();
                },
                onCancel: () {}),
          ),
        ],
      );

  void translate() async {
    final languages = Get.find<MainController>().locals().languages;
    final lan = await QPanel(
        child: Column(
      children: [
        const Text('Translate from'),
        ...languages
            .map((e) => TextButton(
                  onPressed: () => QOverlay.dismissLast(result: e),
                  child: Text(e),
                ))
            .toList()
      ],
    )).show<String>();
    if (lan == null) return;
    final settings = Get.find<SettingsController>().settings().tranlation;
    if (settings.googleApi.isEmpty) {
      showError('api key is missing',
          'Google api key is empty, please set it first in the settings');
      return;
    }
    final serivce = GoogleTranslatorService(settings.googleApi);
    await serivce.tranlate(controller.item, lan);
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
