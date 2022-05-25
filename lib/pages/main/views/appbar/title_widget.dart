import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../controllers/main_controller.dart';

class TitleWidget extends GetView<MainController> {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFF303030),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller.appFile.name,
              style: const TextStyle(fontSize: 20),
            ),
            Observer(
                builder: (_) => controller.loading.value
                    ? const LinearProgressIndicator()
                    : const SizedBox.shrink()),
          ],
        ),
      );
}
