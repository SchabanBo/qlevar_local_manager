import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../local_item/header.dart';
import '../../import_page/import_icon.dart';
import 'exit_icon.dart';
import 'add_language.dart';
import '../controllers/item_controller.dart';
import '../../settings_page/settings_icon.dart';
import '../../export_page/views/export_icon.dart';
import '../local_item/binder.dart';
import '../local_node/binder.dart';
import '../../../models/qlocal.dart';
import '../controllers/main_controller.dart';
import 'options_row.dart';
import 'save_data_widget.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade800,
              ),
              child: Text(controller.appfile.name)),
          leading: OptionsRow(),
          leadingWidth: 250,
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

  Widget get _buildList => Obx(() => Column(
        children: [
          HeaderWidget(
              controller: LocalItemController(
                  LocalItem(name: 'Keys')
                    ..values.addEntries(controller
                        .locals()
                        .languages
                        .map((e) => MapEntry(e, e))),
                  [0])),
          Expanded(
            child: ListView(controller: controller.gridController, children: [
              ...controller.children.map((e) => e is LocalItem
                  ? LocalItemBinder(
                      key: ValueKey(e.hashCode),
                      item: e,
                      indexMap: const [0],
                    )
                  : LocalNodeBinder(
                      key: ValueKey(e.hashCode),
                      item: e as LocalNode,
                      indexMap: const [0],
                    )),
            ]),
          ),
        ],
      ));
}
