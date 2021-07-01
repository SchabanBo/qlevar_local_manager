import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/qlocal.dart';
import 'controller.dart';
import 'widget.dart';

class LocalNodeBinder extends StatelessWidget {
  final QlevarLocalNode item;
  final double startPadding;
  final List<int> indexMap;

  const LocalNodeBinder({
    required this.item,
    required this.indexMap,
    this.startPadding = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalNodeController>(
        global: false,
        init: LocalNodeController(item, indexMap),
        builder: (c) => LocalNodeWidget(
              controller: c,
              startPadding: startPadding,
            ));
  }
}
