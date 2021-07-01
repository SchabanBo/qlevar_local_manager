import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_item.dart';
import '../../../helpers/constants.dart';
import '../controllers/main_controller.dart';
import 'controller.dart';

class OptionsWidget extends StatelessWidget {
  final LocalNodeController controller;
  const OptionsWidget({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ObxValue<RxBool>(
      (open) => MouseRegion(
            onEnter: (_) => open(true),
            onExit: (_) => open(false),
            child: AnimatedSwitcher(
                duration: Constants.animationDuration,
                transitionBuilder: (c, a) => SizeTransition(
                    axis: Axis.horizontal, sizeFactor: a, child: c),
                child: open.isTrue ? options : const Icon(Icons.menu)),
          ),
      false.obs);

  Widget get options => Row(
        children: [
          InkWell(
            child: const Tooltip(
                message: 'Delete',
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            onTap: () => Get.defaultDialog(
                title: 'Delete',
                middleText:
                    'Are you sure you want to delete ${controller.item.value.key}?',
                onConfirm: () {
                  Get.find<MainController>().removeNode(controller.indexMap);
                  Get.back();
                },
                onCancel: () {}),
          ),
          AddLocalNode(indexMap: controller.indexMap),
          AddLocalItem(indexMap: controller.indexMap),
        ],
      );
}
