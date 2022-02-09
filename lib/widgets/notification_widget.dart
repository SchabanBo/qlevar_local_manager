import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/main/controllers/main_controller.dart';

class NotificationWidget extends GetView<MainController> {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(() => AnimatedSwitcher(
      transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation, child: child, alignment: Alignment.centerLeft),
      duration: const Duration(milliseconds: 500),
      child: controller.notification.value.isEmpty
          ? const SizedBox.shrink()
          : Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: controller.notification.value.color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: controller.notification.value.color)),
              child: Center(child: Text(controller.notification.value.message)),
            )));
}
