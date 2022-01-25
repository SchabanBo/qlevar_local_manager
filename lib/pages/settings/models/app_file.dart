import 'dart:convert';

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
