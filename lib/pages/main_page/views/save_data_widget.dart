import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class SaveDataWidget extends GetView<MainController> {
  const SaveDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
        (isSaving) => isSaving.isTrue
            ? const CircularProgressIndicator()
            : IconButton(
                tooltip: 'Save',
                onPressed: () async {
                  isSaving(true);
                  await controller.saveData();
                  isSaving(false);
                },
                icon: const Icon(Icons.save)),
        false.obs);
  }
}
