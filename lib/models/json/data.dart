import 'dart:convert';

const _jsonEncoder = JsonEncoder.withIndent('  ');

class JsonData {
  final data = <JsonNode>[];
  JsonData();

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({for (final e in data) e.name: e.toMap()});
    return result;
  }

  factory JsonData.fromMap(Map<String, dynamic> map) {
    final _data = JsonData();
    for (var item in map.entries) {
      final d = JsonNode(item.key);
      d.fromMap(item.value as Map<String, dynamic>);
      _data.data.add(d);
    }
    return _data;
  }

  String toJson() => _jsonEncoder.convert(toMap());

  factory JsonData.fromJson(String source) =>
      JsonData.fromMap(json.decode(source));
}

abstract class JsonBase {
  String get name;
}

class JsonNode extends JsonBase {
  @override
  final String name;
  final children = <JsonBase>[];
  JsonNode(this.name);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    for (var child in children) {
      if (child is JsonItem) {
        result.addAll({child.name: child.value});
      } else if (child is JsonNode) {
        result.addAll({child.name: child.toMap()});
      }
    }

    return result;
  }

  void fromMap(Map<String, dynamic> map) {
    for (var item in map.entries) {
      if (item.value is String) {
        children.add(JsonItem(name: item.key, value: item.value));
        continue;
      }
      final node = JsonNode(item.key);
      node.fromMap(item.value as Map<String, dynamic>);
      children.add(node);
    }
  }

  String toJson() => _jsonEncoder.convert(toMap());
}

class JsonItem extends JsonBase {
  @override
  final String name;
  final String value;
  JsonItem({
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory JsonItem.fromMap(Map<String, dynamic> map) {
    return JsonItem(
      name: map['name'],
      value: map['value'],
    );
  }

  String toJson() => _jsonEncoder.convert(toMap());

  factory JsonItem.fromJson(String source) =>
      JsonItem.fromMap(json.decode(source));
}
