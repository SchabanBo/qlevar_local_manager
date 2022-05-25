import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../../widgets/export/controllers/export_controller.dart';
import '../../main/controllers/main_controller.dart';
import '../models/models.dart';

class SettingsController extends GetxController {
  final Observable<Settings> settings;
  Timer? _timer;
  SettingsController(Settings _settings) : settings = _settings.asObservable;

  @override
  void onReady() {
    super.onReady();
    settings.addListener(_runAutoSave);
    _runAutoSave();
  }

  void _runAutoSave() {
    final s = settings.value;
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
