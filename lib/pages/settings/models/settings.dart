import 'dart:convert';

import 'models.dart';

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
