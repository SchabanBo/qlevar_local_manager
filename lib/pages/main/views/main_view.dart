import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/notification_widget.dart';
import '../local_item/header.dart';
import 'appbar/appbar.dart';
import '../controllers/item_controller.dart';
import '../local_item/binder.dart';
import '../local_node/binder.dart';
import '../../../models/qlocal.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QAppBar(),
      body: _buildList,
    );
  }

  Widget get _buildList => Obx(() => Column(
        children: [
          const NotificationWidget(),
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
