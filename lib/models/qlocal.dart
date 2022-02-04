import 'json/data.dart';

class QlevarLocal extends LocalNode {
  final List<String> languages = [];

  QlevarLocal() : super(name: '');

  factory QlevarLocal.fromData(JsonData data) {
    final result = QlevarLocal();
    result.languages.addAll(data.data.map((e) => e.name));

    for (var rootObject in data.data) {
      final currentLan = rootObject.name;
      for (var child in rootObject.children) {
        if (child is JsonNode) {
          result.addLocalNode(currentLan, child);
        } else if (child is JsonItem) {
          result.addLocalItem(currentLan, child);
        }
      }
    }

    result.ensureAllLanguagesExist(result.languages);
    return result;
  }

  JsonData toData() {
    final result = JsonData();
    for (var currentLan in languages) {
      final obj = JsonNode(currentLan);
      for (var child in children) {
        if (child is LocalNode) {
          obj.children.add(child.getNode(currentLan));
        } else if (child is LocalItem) {
          obj.children.add(child.getItem(currentLan));
        }
      }
      result.data.add(obj);
    }
    return result;
  }
}

abstract class LocalBase {
  String get name;

  bool filter(String f);

  void ensureAllLanguagesExist(List<String> languages);
}

class LocalNode extends LocalBase {
  @override
  String name;
  final children = <LocalBase>[];

  List<LocalItem> get items => children.whereType<LocalItem>().toList();
  List<LocalNode> get nodes => children.whereType<LocalNode>().toList();
  bool get hasChildren => children.isNotEmpty;

  LocalNode({required this.name});

  void addLocalNode(String currentLan, JsonNode obj) {
    if (!children.any((e) => e.name == obj.name)) {
      children.add(LocalNode(name: obj.name));
    }
    final match =
        children.whereType<LocalNode>().firstWhere((e) => e.name == obj.name);
    for (var child in obj.children) {
      if (child is JsonNode) {
        match.addLocalNode(currentLan, child);
      } else if (child is JsonItem) {
        match.addLocalItem(currentLan, child);
      }
    }
  }

  void addLocalItem(String currentLan, JsonItem node) {
    if (!children.any((e) => e.name == node.name)) {
      children.add(LocalItem(name: node.name));
    }
    children
        .whereType<LocalItem>()
        .firstWhere((e) => e.name == node.name)
        .add(currentLan, node.value);
  }

  @override
  void ensureAllLanguagesExist(List<String> languages) {
    for (var child in children) {
      child.ensureAllLanguagesExist(languages);
    }
  }

  JsonNode getNode(String currentLan) {
    final result = JsonNode(name);
    for (var child in children) {
      if (child is LocalNode) {
        result.children.add(child.getNode(currentLan));
      } else if (child is LocalItem) {
        result.children.add(child.getItem(currentLan));
      }
    }
    return result;
  }

  @override
  bool filter(String f) => name.contains(f) || children.any((i) => i.filter(f));
}

class LocalItem extends LocalBase {
  @override
  String name;
  final values = <String, String>{};
  LocalItem({required this.name});

  void add(String currentLan, String value) {
    values.addAll({currentLan: value});
  }

  @override
  void ensureAllLanguagesExist(List<String> languages) {
    for (var language in languages) {
      if (!values.containsKey(language)) {
        add(language, '');
      }
    }
  }

  JsonItem getItem(String currentLan) {
    return JsonItem(name: name, value: values[currentLan] ?? '');
  }

  @override
  bool filter(String f) => name.contains(f);
}
