import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../models/qlocal.dart';
import '../../settings_page/controller.dart';
import '../../../services/translators/google_translator_service.dart';
import '../../../helpers/constants.dart';
import '../controllers/main_controller.dart';
import 'controller.dart';

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
                  color: Constants.iconColors,
                )),
            onTap: copyPath,
          ),
          const SizedBox(width: 5),
          InkWell(
            child: const Tooltip(
                message: 'Translate',
                child: Icon(
                  Icons.translate,
                  color: Constants.iconColors,
                )),
            onTap: translate,
          ),
          const SizedBox(width: 5),
          InkWell(
            child: const Tooltip(
                message: 'Delete',
                child: Icon(
                  Icons.delete_outline,
                  color: Constants.iconColors,
                )),
            onTap: () => Get.defaultDialog(
                title: 'Delete',
                middleText:
                    'Are you sure you want to delete ${controller.item.key}?',
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
    final lan = await Get.dialog(AlertDialog(
      title: const Text('Translate from'),
      actions: languages
          .map((e) =>
              TextButton(onPressed: () => Get.back(result: e), child: Text(e)))
          .toList(),
    ));
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
    QlevarLocalNode node = Get.find<MainController>().locals();
    for (var i = 1; i < indexMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.index == indexMap[i]);
      result += node.key + '_';
    }
    final item = node.items.firstWhere((e) => e.index == indexMap.last);
    result += item.key;
    Clipboard.setData(ClipboardData(text: result));
  }
}
