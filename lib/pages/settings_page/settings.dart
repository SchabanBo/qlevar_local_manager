import 'dart:convert';

import 'package:qlevar_local_manager/pages/export_page/controller.dart';

class Settings {
  final List<AppLocalFile> apps;
  final TranlationSettings tranlation;
  final AutoSave autoSave;
  Settings({
    required this.apps,
    required this.tranlation,
    required this.autoSave,
  });

  Map<String, dynamic> toMap() {
    return {
      'apps': apps.map((x) => x.toMap()).toList(),
      'tranlation': tranlation.toMap(),
      'autoSave': autoSave.toMap(),
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      apps: List<AppLocalFile>.from(
          map['apps']?.map((x) => AppLocalFile.fromMap(x))),
      tranlation: map['tranlation'] == null
          ? TranlationSettings()
          : TranlationSettings.fromMap(map['tranlation']),
      autoSave: map['autoSave'] == null
          ? AutoSave()
          : AutoSave.fromMap(map['autoSave']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));
}

class AppLocalFile {
  final String name;
  final String path;
  final String exportPath;
  const AppLocalFile({
    required this.name,
    required this.path,
    required this.exportPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': path,
      'exportPath': exportPath,
    };
  }

  factory AppLocalFile.fromMap(Map<String, dynamic> map) {
    return AppLocalFile(
      name: map['name'],
      path: map['path'],
      exportPath: map['exportPath'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppLocalFile.fromJson(String source) =>
      AppLocalFile.fromMap(json.decode(source));
}

class TranlationSettings {
  String googleApi;

  TranlationSettings({
    this.googleApi = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'googleApi': googleApi,
    };
  }

  factory TranlationSettings.fromMap(Map<String, dynamic> map) {
    return TranlationSettings(
      googleApi: map['googleApi'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TranlationSettings.fromJson(String source) =>
      TranlationSettings.fromMap(json.decode(source));
}

class AutoSave {
  bool enabled;
  int interval;
  bool export;
  ExportAs exportAs;

  AutoSave({
    this.enabled = true,
    this.interval = 60,
    this.export = true,
    this.exportAs = ExportAs.getx,
  });

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'interval': interval,
      'export': export,
      'exportAs': exportAs.toString(),
    };
  }

  factory AutoSave.fromMap(Map<String, dynamic> map) {
    return AutoSave(
      enabled: map['enabled'],
      interval: map['interval'],
      export: map['export'],
      exportAs: map['exportAs'] == null
          ? ExportAs.getx
          : ExportAs.values
              .firstWhere((element) => map['exportAs'] == element.toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoSave.fromJson(String source) =>
      AutoSave.fromMap(json.decode(source));
}
