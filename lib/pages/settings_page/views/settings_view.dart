import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auto_save_section.dart';
import 'apps_section.dart';
import 'translation_settings.dart';
import '../controller.dart';

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
    controller.save();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
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
              AppsSection(controller, widget.isSelectApp),
              TranslationSection(controller),
              AutoSaveSection(controller),
            ],
          ),
        ),
      ),
    );
  }
}
