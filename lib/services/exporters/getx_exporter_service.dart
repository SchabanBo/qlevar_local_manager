import 'dart:convert';

import '../../models/json/data.dart';
import '../di_service.dart';
import '../storage_service.dart';

class GetxExporterService {
  final JsonData data;
  GetxExporterService({required this.data});

  void export(String toFile) {
    final result = '''
// Code generated at ${DateTime.now()} by Qlevar Local Manager

class AppTranslation {
  static Map<String, Map<String, String>> translations = {${getDataAsString()}  };
}
  ''';

    getService<StorageService>().writeFile(toFile, result);
  }

  String getDataAsString() {
    var result = '';
    for (var node in data.data) {
      result += '\n    "${node.name}": ${flatNodes('', node)},\n';
    }
    return result;
  }

  Map<String, String> flatNodes(String parent, JsonNode node) {
    final result = <String, String>{};
    parent = parent.isEmpty ? '' : '${parent}_';
    for (var child in node.children) {
      if (child is JsonNode) {
        result.addAll(flatNodes('$parent${child.name}', child));
      } else if (child is JsonItem) {
        result['\n      "$parent${child.name}"'] = jsonEncode(child.value);
      }
    }
    return result;
  }
}
