import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_controller.dart';

class TitleWidget extends StatelessWidget {
  final MainController mainController = Get.find();
  TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade800,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            mainController.appfile.name,
            style: const TextStyle(fontSize: 20),
          ),
          Obx(() => mainController.loading.isTrue
              ? const LinearProgressIndicator()
              : const SizedBox.shrink()),
        ],
      ));
}
