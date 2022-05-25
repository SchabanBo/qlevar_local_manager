import 'package:flutter/material.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../../models/qlocal.dart';
import '../../../services/di_service.dart';
import '../controllers/item_controller.dart';
import '../controllers/main_controller.dart';
import '../local_item/binder.dart';
import '../local_item/header.dart';
import '../local_node/binder.dart';
import 'appbar/appbar.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  MainController get controller => getService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QAppBar(),
      body: _buildList,
    );
  }

  Widget get _buildList => Observer(
      builder: (_) => Column(
            children: [
              HeaderWidget(
                  controller: LocalItemController(
                      LocalItem(name: 'Keys')
                        ..values.addEntries(controller.locals.value.languages
                            .map((e) => MapEntry(e, e))),
                      [0])),
              Expanded(
                child:
                    ListView(controller: controller.gridController, children: [
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
