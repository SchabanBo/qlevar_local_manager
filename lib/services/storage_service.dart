import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/download/download.dart'
    if (dart.library.html) '../helpers/download/download_web.dart';
import '../models/json/data.dart';
import '../models/qlocal.dart';
import '../pages/settings/models/models.dart';

const _key = 'qlevar_local_manager_settings';

class StorageService extends GetxController {
  Future<Settings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_key)) {
      return Settings.fromJson(prefs.getString(_key)!);
    }
    return Settings(
        apps: [], translation: TranlationSettings(), autoSave: AutoSave());
  }

  Future saveSettings(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, settings.toJson());
  }

  Future<QlevarLocal?> loadLocals(AppLocalFile appLocalFile) async {
    if (kIsWeb) return await _loadLocalsWeb(appLocalFile);

    try {
      final file = File(appLocalFile.path);
      if (!(await file.exists())) await file.create(recursive: true);
      var data = await File(appLocalFile.path).readAsString();
      if (data.isEmpty) data = '{"en":{}}';
      final l = JsonData.fromJson(data);
      return QlevarLocal.fromData(l);
    } catch (e) {
      Get.defaultDialog(
          title: 'Error reading the data', middleText: e.toString());
    }
    return null;
  }

  Future<QlevarLocal?> _loadLocalsWeb(AppLocalFile appLocalFile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _key + '_' + appLocalFile.name;
      if (!prefs.containsKey(key)) await prefs.setString(key, '{"en":{}}');
      final data = prefs.getString(key)!;
      final l = JsonData.fromJson(data);
      return QlevarLocal.fromData(l);
    } catch (e) {
      Get.defaultDialog(
          title: 'Error reading the data', middleText: e.toString());
    }
    return null;
  }

  Future<void> saveLocals(AppLocalFile file, QlevarLocal local) async {
    if (kIsWeb) return await _saveLocalsWeb(file, local);
    final data = local.toData();
    await File(file.path).writeAsString(data.toJson());
  }

  Future<void> _saveLocalsWeb(AppLocalFile file, QlevarLocal local) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _key + '_' + file.name;
    await prefs.setString(key, local.toData().toJson());
  }

  void writeFile(String path, String data) async {
    if (kIsWeb) {
      _writeFileWeb(path, data);
      return;
    }
    final file = File(path);
    if (!(await file.exists())) await file.create(recursive: true);
    await file.writeAsString(data);
  }

  void _writeFileWeb(String path, String data) async {
    downloadFile(path.substring(1), data);
  }

  Future<String?> readFile(String path) async {
    final file = File(path);
    if (!(await file.exists())) return null;
    return await file.readAsString();
  }

  Future<void> importLocalsWeb(String name, String data) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _key + '_' + name;
    await prefs.setString(key, data);
  }

  Future<void> exportLocalsWeb(AppLocalFile file, QlevarLocal local) async {
    _writeFileWeb(' ${file.name}.json', local.toData().toJson());
  }
}
