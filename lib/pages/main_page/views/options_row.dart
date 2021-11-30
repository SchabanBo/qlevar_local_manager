import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class OptionsRow extends StatelessWidget {
  final controller = Get.find<MainController>();
  OptionsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(children: [
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            onChanged: controller.filter,
            decoration: const InputDecoration(
              hintText: 'Filter',
            ),
          ),
        ),
        Obx(() => IconButton(
              icon: Icon(
                controller.openAllNodes.isTrue
                    ? Icons.unfold_less
                    : Icons.unfold_more,
              ),
              tooltip:
                  controller.openAllNodes.isTrue ? 'Close All' : 'Expand All',
              onPressed: () =>
                  controller.openAllNodes(!controller.openAllNodes.value),
            ))
      ]);
}
