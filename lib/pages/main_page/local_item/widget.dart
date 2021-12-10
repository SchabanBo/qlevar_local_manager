import 'package:flutter/material.dart';
import 'options_widget.dart';
import 'editable_text_widget.dart';
import 'controller.dart';

class LocalItemWidget extends StatelessWidget {
  final double startPadding;
  final LocalItemController controller;
  const LocalItemWidget({
    required this.controller,
    this.startPadding = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: null,
          border: Border(bottom: BorderSide(color: Colors.grey.shade700)),
        ),
        child: Row(
          children: [
            SizedBox(width: startPadding + 8),
            Expanded(
                child: QEditableText(
                    text: controller.item.key,
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
