import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../helpers/constants.dart';
import '../../settings_page/settings.dart';
import '../../../models/qlocal.dart';

class MainController extends GetxController {
  final AppLocalFile appfile;
  final Rx<QlevarLocal> locals;
  final openAllNodes = false.obs;
  final loading = false.obs;
  final filter = ''.obs;
  late final gridController = ScrollController();
  MainController({required this.appfile, required QlevarLocal locals})
      : locals = locals.obs;

  int get listItemsCount => locals().items.length + locals().nodes.length;

  Iterable<QlevarLocalItem> get getItem => filter.isEmpty
      ? locals().items
      : locals().items.where((i) => i.filter(filter()));

  Iterable<QlevarLocalNode> get getNodes => filter.isEmpty
      ? locals().nodes
      : locals().nodes.where((i) => i.filter(filter()));

  void addItem(List<int> hashMap, QlevarLocalItem item, {int? inserthashCode}) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < hashMap.length; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    if (node.items.any((e) => e.key == item.key)) {
      showError('Error', 'Key with name ${item.key} already exist');
      return;
    }
    item.ensureAllLanguagesExist(locals().languages);
    if (item.values.entries.first.value.isEmpty) {
      item.values[locals().languages.first] = item.key;
    }

    if (inserthashCode != null) {
      node.items.insert(
          node.items.indexWhere((e) => e.hashCode == inserthashCode), item);
    } else {
      node.items.add(item);
    }

    locals.refresh();
  }

  void addNode(List<int> hashMap, QlevarLocalNode node, {int? inserthashCode}) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < hashMap.length; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    if (node.items.any((e) => e.key == node.key)) {
      showError('Error', 'Key with name ${node.key} already exist');
      return;
    }
    if (inserthashCode != null) {
      node.nodes.insert(
          node.items.indexWhere((e) => e.hashCode == inserthashCode), node);
    } else {
      node.nodes.add(node);
    }
    locals.refresh();
  }

  void updateLocalItem(List<int> hashMap, String language, String value) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    final item = node.items.firstWhere((e) => e.hashCode == hashMap.last);
    item.values[language] = value;
    locals.refresh();
  }

  void updateLocalItemKey(List<int> hashMap, String value) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    if (node.items.any((e) => e.hashCode != hashMap.last && e.key == value)) {
      showError('Error', 'Key with name $value already exist');
      update();
      return;
    }
    final item = node.items.firstWhere((e) => e.hashCode == hashMap.last);
    item.key = value;
    locals.refresh();
  }

  void removeItem(List<int> hashMap, {bool update = true}) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    final item = node.items.firstWhere((e) => e.hashCode == hashMap.last);
    node.items.remove(item);
    if (update) {
      locals.refresh();
    }
  }

  void removeNode(List<int> hashMap, {bool update = true}) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    final item = node.nodes.firstWhere((e) => e.hashCode == hashMap.last);
    node.nodes.remove(item);
    if (update) {
      locals.refresh();
    }
  }

  Future<void> saveData() async {
    loading(true);
    final data = locals().toData();
    await File(appfile.path).writeAsString(data.toJson());
    loading(false);
  }

  @override
  void onClose() {
    gridController.dispose();
    super.onClose();
  }
}
