import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../local_node/add_item.dart';
import 'options_widget.dart';
import 'editable_text_widget.dart';
import 'controller.dart';

class LocalItemWidget extends StatelessWidget {
  final double startPadding;
  final LocalItemController controller;
  final bool isHeader;
  const LocalItemWidget({
    required this.controller,
    this.isHeader = false,
    this.startPadding = 0,
    Key? key,
  }) : super(key: key);

  final TextStyle headerStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) => Container(
        padding: isHeader ? const EdgeInsets.only(bottom: 8) : null,
        decoration: BoxDecoration(
          color: isHeader ? Get.theme.bottomAppBarColor : null,
          border: Border(
            bottom: BorderSide(
              color: Get.theme.colorScheme.primary.withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: startPadding + 8),
            Expanded(
                child: isHeader
                    ? Text(controller.item.key, style: headerStyle)
                    : QEditableText(
                        text: controller.item.key,
                        onEdit: (s) => controller.updateKey(s))),
            ...controller.item.values.entries.map((kv) => Expanded(
                child: isHeader
                    ? Text(kv.value, style: headerStyle)
                    : QEditableText(
                        key: Key(kv.key + "_" + kv.value),
                        text: kv.value,
                        onEdit: (s) => controller.updateValue(kv.key, s)))),
            isHeader
                ? Row(
                    children: const [
                      SizedBox(width: 5),
                      AddLocalNode(indexMap: [0]),
                      SizedBox(width: 5),
                      AddLocalItem(indexMap: [0]),
                    ],
                  )
                : OptionsWidget(controller: controller),
            const SizedBox(width: 8),
          ],
        ),
      );
}
