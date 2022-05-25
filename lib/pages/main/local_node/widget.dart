import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../../helpers/constants.dart';
import '../../../models/drag_request.dart';
import '../../../models/qlocal.dart';
import '../controllers/main_controller.dart';
import '../controllers/node_controller.dart';
import '../local_item/binder.dart';
import '../local_item/editable_text_widget.dart';
import 'binder.dart';
import 'options_widget.dart';

const _noChildren =
    Padding(padding: EdgeInsets.all(8.0), child: Text('No Children'));

class LocalNodeWidget extends StatelessWidget {
  final LocalNodeController controller;
  LocalNodeWidget({required this.controller, Key? key}) : super(key: key);

  late final _widget = _LocalNodeWidget(
    controller: controller,
  );

  late final _dragRequest =
      NodeDragRequest(controller.item.value, controller.indexMap);

  @override
  Widget build(BuildContext context) => Draggable<NodeDragRequest>(
      feedback: const SizedBox.shrink(),
      data: _dragRequest,
      childWhenDragging: Container(
        height: 30,
        width: double.infinity,
        color: AppColors.drag,
      ),
      child: _widget);
}

class _LocalNodeWidget extends StatelessWidget {
  final LocalNodeController controller;
  const _LocalNodeWidget({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: AppColors.border),
            bottom: BorderSide(color: AppColors.border),
          ),
        ),
        child: Observer(builder: (_) => Column(children: [header, body])),
      );

  Widget get header => Container(
        decoration: const BoxDecoration(
          color: AppColors.node,
          border: Border(
            bottom: BorderSide(color: AppColors.border),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Flexible(
              flex: 1,
              child: QEditableText(
                  text: controller.item.value.name,
                  onEdit: (s) => controller.item.value.name = s),
            ),
            Expanded(
              flex: Get.find<MainController>().locals.value.languages.length,
              child: InkWell(
                onTap: () => controller.isOpen(!controller.isOpen.value),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Observer(
                      builder: (_) => Icon(
                            controller.isOpen.value
                                ? Icons.expand_less
                                : Icons.expand_more,
                            size: 30,
                          )),
                ),
              ),
            ),
            const SizedBox(width: 5),
            OptionsWidget(controller: controller),
            const SizedBox(width: 8),
          ],
        ),
      );

  Widget get body => AnimatedSwitcher(
        switchInCurve: Curves.linearToEaseOut,
        switchOutCurve: Curves.linearToEaseOut,
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (c, a) =>
            SizeTransition(sizeFactor: a, axis: Axis.vertical, child: c),
        child: controller.isOpen.value
            ? controller.children.isEmpty
                ? _noChildren
                : ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                        ...controller.children.map((e) => e is LocalItem
                            ? LocalItemBinder(
                                key: ValueKey(e.hashCode),
                                item: e,
                                indexMap: controller.indexMap,
                              )
                            : LocalNodeBinder(
                                key: ValueKey(e.hashCode),
                                item: e as LocalNode,
                                indexMap: controller.indexMap,
                              )),
                      ])
            : const SizedBox(),
      );
}
