import 'local_data.dart';

int _counter = 0;

class QlevarLocal extends QlevarLocalNode {
  final List<String> languages = [];
  int itemCount = 0;

  QlevarLocal() : super(key: '');

  factory QlevarLocal.fromData(LocalData data) {
    _counter = 0;
    final result = QlevarLocal();
    result.languages.addAll(data.data.map((e) => e.name));

    for (var rootObject in data.data) {
      final currentLan = rootObject.name;
      for (final obj in rootObject.nodes) {
        result.addLocalObject(currentLan, obj);
      }
      for (final node in rootObject.items) {
        result.addLocalNode(currentLan, node);
      }
    }

    result.ensureAllLanguagesExist(result.languages);
    result.itemCount = _counter;
    return result;
  }

  LocalData toData() {
    final result = LocalData();
    for (var currentLan in languages) {
      final obj = LocalNode(currentLan);
      for (var item in nodes) {
        obj.nodes.add(item.getNode(currentLan));
      }
      for (var item in items) {
        obj.items.add(item.getItem(currentLan));
      }
      result.data.add(obj);
    }
    return result;
  }
}

class QlevarLocalNode {
  String key;
  final int index = _counter++;
  final nodes = <QlevarLocalNode>[];
  final items = <QlevarLocalItem>[];
  QlevarLocalNode({required this.key});

  void addLocalObject(String currentLan, LocalNode obj) {
    if (!nodes.any((e) => e.key == obj.name)) {
      nodes.add(QlevarLocalNode(key: obj.name));
    }
    final match = nodes.firstWhere((e) => e.key == obj.name);
    for (var item in obj.nodes) {
      match.addLocalObject(currentLan, item);
    }
    for (var item in obj.items) {
      match.addLocalNode(currentLan, item);
    }
  }

  void addLocalNode(String currentLan, LocalItem node) {
    if (!items.any((e) => e.key == node.key)) {
      items.add(QlevarLocalItem(key: node.key));
    }
    items.firstWhere((e) => e.key == node.key).add(currentLan, node.value);
  }

  void ensureAllLanguagesExist(List<String> languages) {
    for (var item in nodes) {
      item.ensureAllLanguagesExist(languages);
    }
    for (var item in items) {
      item.ensureAllLanguagesExist(languages);
    }
  }

  LocalNode getNode(String currentLan) {
    final result = LocalNode(key);
    for (var item in nodes) {
      result.nodes.add(item.getNode(currentLan));
    }
    for (var item in items) {
      result.items.add(item.getItem(currentLan));
    }
    return result;
  }
}

class QlevarLocalItem {
  String key;
  final int index = _counter++;
  final values = <String, String>{};
  QlevarLocalItem({required this.key});

  void add(String currentLan, String value) {
    values.addAll({currentLan: value});
  }

  void ensureAllLanguagesExist(List<String> languages) {
    for (var language in languages) {
      if (!values.containsKey(language)) {
        add(language, '');
      }
    }
  }

  LocalItem getItem(String currentLan) {
    return LocalItem(key: key, value: values[currentLan] ?? '');
  }
}
