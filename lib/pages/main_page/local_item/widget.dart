import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/constants.dart';
import '../../../models/drag_request.dart';
import 'options_widget.dart';
import 'editable_text_widget.dart';
import '../controllers/item_controller.dart';

class LocalItemWidget extends StatelessWidget {
  final double startPadding;
  final LocalItemController controller;
  LocalItemWidget({
    required this.controller,
    this.startPadding = 0,
    Key? key,
  }) : super(key: key);

  late final _widget = _LocalItemWidget(
    controller: controller,
    startPadding: startPadding,
  );

  late final _dragRequest =
      ItemDragRequest(controller.item, controller.indexMap);

  @override
  Widget build(BuildContext context) => DragTarget<DragRequest>(
        onWillAccept: (data) => data is DragRequest && data != _dragRequest,
        onAccept: controller.handleDrag,
        builder: (c, data, _) => data.isEmpty
            ? Draggable<ItemDragRequest>(
                feedback: const SizedBox.shrink(),
                data: _dragRequest,
                childWhenDragging: Container(
                  height: 30,
                  width: Get.width,
                  color: AppColors.drag,
                ),
                child: _widget)
            : Column(
                children: [
                  Material(
                    color: AppColors.drag,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: startPadding + 8, vertical: 4),
                      width: Get.width,
                      child: Text(data.first!.key,
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  _widget,
                ],
              ),
      );
}

class _LocalItemWidget extends StatelessWidget {
  final double startPadding;
  final LocalItemController controller;
  const _LocalItemWidget({
    required this.controller,
    this.startPadding = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          SizedBox(width: startPadding + 8),
          Expanded(
              child: QEditableText(
                  text: controller.item.name,
                  onEdit: (s) => controller.updateKey(s))),
          ...controller.item.values.entries.map((kv) => Expanded(
              child: QEditableText(
                  key: Key(kv.key + "_" + kv.value),
                  text: kv.value,
                  onEdit: (s) => controller.updateValue(kv.key, s)))),
          OptionsWidget(controller: controller),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
