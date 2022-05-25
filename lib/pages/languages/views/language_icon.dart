import 'package:flutter/material.dart';
import 'package:q_overlay/q_overlay.dart';

import '../../../helpers/constants.dart';
import '../../../services/di_service.dart';
import '../controllers/language_controller.dart';
import 'language_view.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Language Settings',
        onPressed: () async {
          addService(LanguageController());
          await QPanel(
            name: 'Settings Screen',
            child: const LanguageView(),
            alignment: Alignment.centerRight,
          ).show();
          removeService<LanguageController>();
        },
        icon: const Icon(
          Icons.language,
          color: AppColors.icon,
        ));
  }
}
