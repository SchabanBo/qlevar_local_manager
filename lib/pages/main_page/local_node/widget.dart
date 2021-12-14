import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/drag_request.dart';
import '../../../models/qlocal.dart';
import '../local_item/editable_text_widget.dart';
import '../controllers/main_controller.dart';
import 'options_widget.dart';
import '../local_item/binder.dart';
import 'binder.dart';
import '../controllers/node_controller.dart';

class LocalNodeWidget extends StatelessWidget {
  final double startPadding;
  final LocalNodeController controller;
  LocalNodeWidget({required this.controller, this.startPadding = 0, Key? key})
      : super(key: key);

  late final _widget = _LocalNodeWidget(
    controller: controller,
    startPadding: startPadding,
  );

  late final _dragRequest =
      NodeDragRequest(controller.item.value, controller.indexMap);

  @override
  Widget build(BuildContext context) => Draggable<NodeDragRequest>(
      feedback: const SizedBox.shrink(),
      data: _dragRequest,
      childWhenDragging: Container(
        height: 30,
        width: Get.width,
        color: Colors.grey.shade700,
      ),
      child: _widget);
}

class _LocalNodeWidget extends StatelessWidget {
  final double startPadding;
  final LocalNodeController controller;
  const _LocalNodeWidget(
      {required this.controller, this.startPadding = 0, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(left: startPadding),
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Obx(() => Column(children: [header, body])),
      );

  Widget get header => Container(
        decoration: const BoxDecoration(
          color: Color(0xff303030),
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Flexible(
              flex: 1,
              child: QEditableText(
                  text: controller.item().name,
                  onEdit: (s) => controller.item().name = s),
            ),
            Expanded(
              flex: Get.find<MainController>().locals().languages.length,
              child: InkWell(
                onTap: controller.isOpen.toggle,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() => Icon(
                        controller.isOpen.isTrue
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
            SizeTransition(sizeFactor: a, child: c, axis: Axis.vertical),
        child: controller.isOpen.isTrue
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                    ...controller.children.map((e) => e is LocalItem
                        ? LocalItemBinder(
                            key: ValueKey(e.hashCode),
                            item: e,
                            indexMap: controller.indexMap,
                            startPadding: 8 + startPadding,
                          )
                        : LocalNodeBinder(
                            key: ValueKey(e.hashCode),
                            item: e as LocalNode,
                            indexMap: controller.indexMap,
                            startPadding: 8 + startPadding,
                          )),
                  ])
            : const SizedBox(),
      );
}
