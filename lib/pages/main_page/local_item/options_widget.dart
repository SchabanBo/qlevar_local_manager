import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../settings_page/controller.dart';
import '../../../services/translators/google_translator_service.dart';
import '../../../helpers/constants.dart';
import '../controllers/main_controller.dart';
import 'controller.dart';

class OptionsWidget extends StatelessWidget {
  final LocalItemController controller;
  const OptionsWidget({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ObxValue<RxBool>(
      (open) => MouseRegion(
            onEnter: (_) => open(true),
            onExit: (_) => open(false),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: AnimatedSwitcher(
                  duration: Constants.animationDuration,
                  transitionBuilder: (c, a) => SizeTransition(
                      axis: Axis.horizontal, sizeFactor: a, child: c),
                  child: open.isTrue ? options : const Icon(Icons.menu)),
            ),
          ),
      false.obs);

  Widget get options => Row(
        children: [
          InkWell(
            child: const Tooltip(
                message: 'Delete',
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
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
          InkWell(
            child: const Tooltip(
                message: 'Translate',
                child: Icon(
                  Icons.translate,
                  color: Colors.green,
                )),
            onTap: translate,
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
}
