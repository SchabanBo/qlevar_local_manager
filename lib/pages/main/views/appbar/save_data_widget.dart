import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/constants.dart';
import '../../../../services/di_service.dart';
import '../../../../services/storage_service.dart';
import '../../controllers/main_controller.dart';

class SaveDataWidget extends StatelessWidget {
  const SaveDataWidget({Key? key}) : super(key: key);
  MainController get controller => getService();

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
                  getService<StorageService>().exportLocalsWeb(
                      controller.appFile, controller.locals.value);
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
