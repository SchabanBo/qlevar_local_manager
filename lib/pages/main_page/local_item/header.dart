import 'package:flutter/material.dart';

import '../local_node/add_item.dart';
import '../controllers/item_controller.dart';

class HeaderWidget extends StatelessWidget {
  final double startPadding;
  final LocalItemController controller;
  const HeaderWidget({
    required this.controller,
    this.startPadding = 0,
    Key? key,
  }) : super(key: key);

  final TextStyle headerStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: startPadding + 8),
            Expanded(child: Text(controller.item.name, style: headerStyle)),
            ...controller.item.values.entries.map(
                (kv) => Expanded(child: Text(kv.value, style: headerStyle))),
            Row(
              children: const [
                SizedBox(width: 5),
                AddLocalNode(indexMap: [0]),
                SizedBox(width: 5),
                AddLocalItem(indexMap: [0]),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
      );
}
