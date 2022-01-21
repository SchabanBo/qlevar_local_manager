import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/constants.dart';
import 'views/settings_view.dart';

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.bottomSheet(const SettingsPage()),
      icon: const Icon(
        Icons.settings,
        color: AppColors.icon,
      ),
      tooltip: 'Settings',
    );
  }
}
