import 'dart:async';

import 'package:get/get.dart';
import 'package:qlevar_local_manager/pages/export_page/controller.dart';
import 'package:qlevar_local_manager/pages/main_page/controllers/main_controller.dart';
import 'settings.dart';

import 'package:shared_preferences/shared_preferences.dart';

const String _key = 'qlevar_local_manager_settings';

class SettingsController extends GetxController {
  final Rx<Settings> settings;
  Timer? _timer;
  SettingsController(Settings _settings) : settings = _settings.obs;

  void save() => SharedPreferences.getInstance()
      .then((value) => value.setString(_key, settings.toJson()));

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
      if (s.autoSave.export) {
        final exporter = ExportController();
        exporter.exportAs(s.autoSave.exportAs);
        exporter.export();
      }
    });
  }
}

class SettingsLoader {
  Future<Settings> load() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_key)) {
      return Settings.fromJson(prefs.getString(_key)!);
    }
    return Settings(
        apps: [], tranlation: TranlationSettings(), autoSave: AutoSave());
  }
}
