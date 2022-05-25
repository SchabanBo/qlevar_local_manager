import 'package:flutter/material.dart';

import '../../../services/di_service.dart';
import '../../../services/storage_service.dart';
import '../controllers/settings_controller.dart';
import 'apps_section.dart';
import 'auto_save_section.dart';
import 'translation_settings.dart';

class SettingsPage extends StatefulWidget {
  final bool isSelectApp;
  const SettingsPage({this.isSelectApp = false, Key? key}) : super(key: key);

  @override
  State createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final controller = getService<SettingsController>();

  @override
  void dispose() {
    getService<StorageService>().saveSettings(controller.settings.value);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(widget.isSelectApp ? 'Select App' : 'Settings',
                    style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(height: 15),
              AppsSection(widget.isSelectApp),
              TranslationSection(controller),
              AutoSaveSection(controller),
            ],
          ),
        ),
      ),
    );
  }
}
