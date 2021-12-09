import 'dart:convert';
import 'dart:io';

import '../../models/local_data.dart';

class GetxExporterService {
  final LocalData data;
  GetxExporterService({required this.data});

  void export(String toFile) {
    final String _class = '''
// Code generated at ${DateTime.now()} by Qlevar local manager

class AppTranslation {
  static Map<String, Map<String, String>> translations = {${getDataAsString()}  };
}
  ''';

    File(toFile).writeAsStringSync(_class);
  }

  String getDataAsString() {
    var result = '';
    for (var node in data.data) {
      result += '\n    "${node.name}": ${flatNodes('', node)},\n';
    }
    return result;
  }

  Map<String, String> flatNodes(String parent, LocalNode node) {
    final result = <String, String>{};
    parent = parent.isEmpty ? '' : parent + '_';
    result.addEntries(node.items.map(
        (e) => MapEntry('\n      "$parent${e.key}"', jsonEncode(e.value))));
    for (var item in node.nodes) {
      result.addAll(flatNodes('$parent${item.name}', item));
    }
    return result;
  }
}
