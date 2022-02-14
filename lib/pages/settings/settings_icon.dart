import 'package:flutter/material.dart';
import 'package:q_overlay/q_overlay.dart';
import '../../helpers/constants.dart';
import 'views/settings_view.dart';

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => QPanel(
        child: const SettingsPage(),
        alignment: Alignment.centerRight,
      ).show(),
      icon: const Icon(
        Icons.settings,
        color: AppColors.icon,
      ),
      tooltip: 'Settings',
    );
  }
}
