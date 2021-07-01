import 'dart:convert';

class Settings {
  final List<AppLocalFile> apps;
  final TranlationSettings tranlation;
  Settings({
    required this.apps,
    required this.tranlation,
  });

  Map<String, dynamic> toMap() {
    return {
      'apps': apps.map((x) => x.toMap()).toList(),
      'tranlation': tranlation.toMap(),
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      apps: List<AppLocalFile>.from(
          map['apps']?.map((x) => AppLocalFile.fromMap(x))),
      tranlation: map['tranlation'] == null
          ? TranlationSettings()
          : TranlationSettings.fromMap(map['tranlation']),
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
      exportPath: map['exportPath'] == null ? '' : map['exportPath'],
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
