import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/storage_service.dart';
import '../../../../helpers/constants.dart';
import '../../controllers/main_controller.dart';

class SaveDataWidget extends GetView<MainController> {
  const SaveDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        kIsWeb
            ? IconButton(
                tooltip: 'Download',
                onPressed: () {
                  controller.saveData();
                  Get.find<StorageService>().exportLocalsWeb(
                      controller.appfile, controller.locals.value);
                },
                icon: const Icon(
                  Icons.download_for_offline,
                  color: AppColors.icon,
                ))
            : const SizedBox.shrink(),
        IconButton(
            tooltip: 'Save',
            onPressed: () => controller.saveData(),
            icon: const Icon(
              Icons.save,
              color: AppColors.icon,
            )),
      ],
    );
  }
}
