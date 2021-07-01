import 'package:flutter/material.dart';
import '../local_node/add_item.dart';
import '../../../helpers/colors.dart';
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
      const TextStyle(fontSize: 20, color: AppColors.primary);

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 45),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(flex: 2, child: keyWidget),
                ...controller.item.values.entries.map((kv) => Expanded(
                    child: isHeader
                        ? Text(kv.value, style: headerStyle)
                        : QEditableText(
                            text: kv.value,
                            onEdit: (s) => controller.updateValue(kv.key, s)))),
              ],
            )),
      );

  Widget get keyWidget => Row(
        children: [
          SizedBox(width: startPadding + 8),
          isHeader
              ? Row(
                  children: const [
                    AddLocalNode(indexMap: [0]),
                    AddLocalItem(indexMap: [0]),
                  ],
                )
              : OptionsWidget(controller: controller),
          const SizedBox(width: 8),
          Expanded(
            child: isHeader
                ? Text(controller.item.key, style: headerStyle)
                : QEditableText(
                    text: controller.item.key,
                    onEdit: (s) => controller.updateKey(s)),
          ),
          const Spacer(),
          const SizedBox(width: 25),
        ],
      );
}
