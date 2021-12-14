import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/constants.dart';
import 'add_item.dart';
import '../controllers/main_controller.dart';
import '../controllers/node_controller.dart';

class OptionsWidget extends StatelessWidget {
  final LocalNodeController controller;
  const OptionsWidget({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => options;

  Widget get options => Row(
        children: [
          AddLocalNode(indexMap: controller.indexMap),
          const SizedBox(width: 5),
          AddLocalItem(indexMap: controller.indexMap),
          const SizedBox(width: 5),
          InkWell(
            child: const Tooltip(
                message: 'Delete',
                child: Icon(
                  Icons.delete_outline,
                  color: Constants.iconColors,
                )),
            onTap: () => Get.defaultDialog(
                title: 'Delete',
                middleText:
                    'Are you sure you want to delete ${controller.item.value.name}?',
                onConfirm: () {
                  Get.find<MainController>().removeNode(controller.indexMap);
                  Get.back();
                },
                onCancel: () {}),
          ),
        ],
      );
}
