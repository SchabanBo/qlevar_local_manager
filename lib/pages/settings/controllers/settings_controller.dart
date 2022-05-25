import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../../services/di_service.dart';
import '../../../widgets/export/controllers/export_controller.dart';
import '../../main/controllers/main_controller.dart';
import '../models/models.dart';

class SettingsController extends Controller {
  final Observable<Settings> settings;
  Timer? _timer;
  SettingsController(Settings settings) : settings = settings.asObservable {
    this.settings.addListener(_runAutoSave);
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
      if (!isServiceRegistered<MainController>()) {
        return;
      }
      getService<MainController>().saveData();
      if (s.autoSave.export && !kIsWeb) {
        final exporter = ExportController();
        exporter.exportAs(s.autoSave.exportAs);
        exporter.export();
      }
    });
  }

  @override
  FutureOr onDispose() {
    settings.removeListener(_runAutoSave);
    _timer?.cancel();
  }
}
