import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../export/controllers/export_controller.dart';
import '../../main/controllers/main_controller.dart';
import '../models/models.dart';

class SettingsController extends GetxController {
  final Rx<Settings> settings;
  Timer? _timer;
  SettingsController(Settings _settings) : settings = _settings.obs;

  @override
  void onReady() {
    super.onReady();
    settings.listen(_runAutoSave);
    _runAutoSave(settings.value);
  }

  void _runAutoSave(Settings s) {
    _timer?.cancel();
    if (!s.autoSave.enabled) {
      _timer == null;
      return;
    }
    _timer = Timer.periodic(Duration(seconds: s.autoSave.interval), (_) {
      if (!Get.isRegistered<MainController>()) {
        return;
      }
      Get.find<MainController>().saveData();
      if (s.autoSave.export && !kIsWeb) {
        final exporter = ExportController();
        exporter.exportAs(s.autoSave.exportAs);
        exporter.export();
      }
    });
  }
}
