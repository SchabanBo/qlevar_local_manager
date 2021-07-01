import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          AddLanguageIcon(),
          SettingsIcon(),
          ExitIcon(),
        ],
      ),
      body: _buildList,
    );
  }

  Widget get _buildList => Obx(() => Column(
        children: [
          // ignore: prefer_const_literals_to_create_immutables
          Card(
              child: LocalItemWidget(
            controller: LocalItemController(
                QlevarLocalItem(key: 'Keys')
                  ..values.addEntries(
                      controller.locals().languages.map((e) => MapEntry(e, e))),
                [0]),
            isHeader: true,
          )),
          Expanded(
            child: ListView(children: [
              ...controller.locals().items.map((e) => LocalItemBinder(
                    key: ValueKey(e.index),
                    item: e,
                    // ignore: prefer_const_literals_to_create_immutables
                    indexMap: [0],
                    startPadding: 8,
                  )),
              ...controller.locals().nodes.map((e) => LocalNodeBinder(
                    key: ValueKey(e.index),
                    item: e,
                    // ignore: prefer_const_literals_to_create_immutables
                    indexMap: [0],
                    startPadding: 8,
                  )),
            ]),
          ),
        ],
      ));
}
