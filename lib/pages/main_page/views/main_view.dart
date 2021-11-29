import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../tree/widget.dart';
import '../../import_page/import_icon.dart';
import 'options_row.dart';
import 'exit_icon.dart';
import 'add_language.dart';
import '../local_item/controller.dart';
import '../local_item/widget.dart';
import '../../settings_page/settings_icon.dart';
import '../../export_page/views/export_icon.dart';
import '../local_item/binder.dart';
import '../local_node/binder.dart';
import '../../../models/qlocal.dart';
import '../controllers/main_controller.dart';
import 'save_data_widget.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(controller.appfile.name),
          actions: const [
            SaveDataWidget(),
            ExportIcon(),
            ImportIcon(),
            AddLanguageIcon(),
            SettingsIcon(),
            ExitIcon(),
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(5),
              child: Obx(() => controller.loading.isTrue
                  ? const LinearProgressIndicator()
                  : const SizedBox.shrink()))),
      body: _buildList,
    );
  }

  Widget get _buildList => Obx(() => Row(
        children: [
          Container(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              color: Get.theme.bottomAppBarColor,
              width: 200,
              child: TreeWidget(controller.locals.value)),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                LocalItemWidget(
                  controller: LocalItemController(
                      QlevarLocalItem(key: 'Keys')
                        ..values.addEntries(controller
                            .locals()
                            .languages
                            .map((e) => MapEntry(e, e))),
                      [0]),
                  isHeader: true,
                ),
                ListView(
                    shrinkWrap: true,
                    primary: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ...controller.getItem.map((e) => LocalItemBinder(
                            key: ValueKey(e.index),
                            item: e,
                            indexMap: const [0],
                          )),
                      ...controller.getNodes.map((e) => LocalNodeBinder(
                            key: ValueKey(e.index),
                            item: e,
                            indexMap: const [0],
                          )),
                    ]),
              ],
            ),
          ),
        ],
      ));
}
