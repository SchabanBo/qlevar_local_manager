import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/storage_service.dart';
import 'auto_save_section.dart';
import 'apps_section.dart';
import 'translation_settings.dart';
import '../controllers/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  final bool isSelectApp;
  const SettingsPage({this.isSelectApp = false, Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final controller = Get.find<SettingsController>();

  @override
  void dispose() {
    Get.find<StorageService>().saveSettings(controller.settings.value);
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
              Text(widget.isSelectApp ? 'Select App' : 'Settings',
                  style: const TextStyle(fontSize: 24)),
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
