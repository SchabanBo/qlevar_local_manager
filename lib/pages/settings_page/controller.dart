import 'package:get/get.dart';
import 'settings.dart';

import 'package:shared_preferences/shared_preferences.dart';

const String _key = 'qlevar_local_manager_settings';

class SettingsController extends GetxController {
  final Rx<Settings> settings;
  SettingsController(Settings _settings) : settings = _settings.obs;

  void save() => SharedPreferences.getInstance()
      .then((value) => value.setString(_key, settings.toJson()));
}

class SettingsLoader {
  Future<Settings> load() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_key)) {
      return Settings.fromJson(prefs.getString(_key)!);
    }
    return Settings(apps: [], tranlation: TranlationSettings());
  }
}
