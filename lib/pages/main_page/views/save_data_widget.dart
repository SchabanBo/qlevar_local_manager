import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class SaveDataWidget extends GetView<MainController> {
  const SaveDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Save',
        onPressed: controller.saveData,
        icon: const Icon(Icons.save));
  }
}
