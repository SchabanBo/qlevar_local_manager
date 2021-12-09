import 'dart:convert';

const _jsonEncoder = JsonEncoder.withIndent('  ');

class LocalData {
  final data = <LocalNode>[];
  LocalData();

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({for (final e in data) e.name: e.toMap()});
    return result;
  }

  factory LocalData.fromMap(Map<String, dynamic> map) {
    final _data = LocalData();
    for (var item in map.entries) {
      final d = LocalNode(item.key);
      d.fromMap(item.value as Map<String, dynamic>);
      _data.data.add(d);
    }
    return _data;
  }

  String toJson() => _jsonEncoder.convert(toMap());

  factory LocalData.fromJson(String source) =>
      LocalData.fromMap(json.decode(source));
}

class LocalNode {
  final String name;
  final List<LocalItem> items = [];
  final List<LocalNode> nodes = [];
  LocalNode(this.name);
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({for (final e in items) e.key: e.value});
    result.addAll({for (final e in nodes) e.name: e.toMap()});
    return result;
  }

  void fromMap(Map<String, dynamic> map) {
    for (var item in map.entries) {
      if (item.value is String) {
        items.add(LocalItem(key: item.key, value: item.value));
        continue;
      }
      final obj = LocalNode(item.key);
      obj.fromMap(item.value as Map<String, dynamic>);
      nodes.add(obj);
    }
  }

  String toJson() => _jsonEncoder.convert(toMap());
}

class LocalItem {
  final String key;
  final String value;
  LocalItem({
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
    };
  }

  factory LocalItem.fromMap(Map<String, dynamic> map) {
    return LocalItem(
      key: map['key'],
      value: map['value'],
    );
  }

  String toJson() => _jsonEncoder.convert(toMap());

  factory LocalItem.fromJson(String source) =>
      LocalItem.fromMap(json.decode(source));
}
