import 'package:flutter/material.dart';

import '../../../models/qlocal.dart';
import '../controllers/item_controller.dart';
import 'widget.dart';

class LocalItemBinder extends StatelessWidget {
  final LocalItem item;
  final double startPadding;
  final List<int> indexMap;

  const LocalItemBinder({
    required this.item,
    required this.indexMap,
    this.startPadding = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = LocalItemController(item, indexMap);
    return LocalItemWidget(
      controller: controller,
      startPadding: startPadding,
    );
  }
}
