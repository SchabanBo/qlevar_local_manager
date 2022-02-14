import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_overlay/q_overlay.dart';
import '../../../helpers/constants.dart';
import '../controllers/language_controller.dart';
import 'language_view.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Language Settings',
        onPressed: () async {
          Get.put(LanguageController());
          await QPanel(
            name: 'SetingsScreen',
            child: const LanguageView(),
            alignment: Alignment.centerRight,
          ).show();
          Get.delete<LanguageController>();
        },
        icon: const Icon(
          Icons.language,
          color: AppColors.icon,
        ));
  }
}
