import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../../models/qlocal.dart';
import '../../../services/storage_service.dart';
import '../../../widgets/notification.dart';
import '../../settings/models/models.dart';

class MainController extends GetxController {
  final AppLocalFile appFile;
  final Observable<QlevarLocal> locals;
  final openAllNodes = false.asObservable;
  final loading = false.asObservable;
  final filter = ''.asObservable;
  late final gridController = ScrollController();
  MainController({required this.appFile, required QlevarLocal locals})
      : locals = locals.asObservable;

  int get listItemsCount => locals.value.children.length;

  Iterable<LocalBase> get children => filter.value.isEmpty
      ? locals.value.children
      : locals.value.children.where((i) => i.filter(filter.value));

  @override
  void onClose() {
    super.onClose();
    gridController.dispose();
    saveData();
  }

  void addItem(List<int> hashMap, LocalItem item, {int? insertHashCode}) {
    LocalNode node = locals.value;
    for (var i = 1; i < hashMap.length; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    if (node.items.any((e) => e.name == item.name)) {
      showNotification('Error', 'Key with name ${item.name} already exist');
      return;
    }
    item.ensureAllLanguagesExist(locals.value.languages);
    if (item.values.entries.first.value.isEmpty) {
      item.values[locals.value.languages.first] = item.name;
    }

    if (insertHashCode != null) {
      node.children.insert(
          node.items.indexWhere((e) => e.hashCode == insertHashCode), item);
    } else {
      node.children.add(item);
    }

    locals.refresh();
  }

  void addNode(List<int> hashMap, LocalNode newNode, {int? insertHashCode}) {
    LocalNode node = locals.value;
    for (var i = 1; i < hashMap.length; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    if (node.items.any((e) => e.name == newNode.name)) {
      showNotification('Error', 'Key with name ${node.name} already exist');
      return;
    }
    if (insertHashCode != null) {
      node.children.insert(
          node.items.indexWhere((e) => e.hashCode == insertHashCode), newNode);
    } else {
      node.children.add(newNode);
    }
    locals.refresh();
  }

  void updateLocalItem(List<int> hashMap, String language, String value) {
    LocalNode node = locals.value;
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    final item = node.items.firstWhere((e) => e.hashCode == hashMap.last);
    item.values[language] = value;
    locals.refresh();
  }

  void updateLocalItemKey(List<int> hashMap, String value) {
    LocalNode node = locals.value;
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    if (node.items.any((e) => e.hashCode != hashMap.last && e.name == value)) {
      showNotification('Error', 'Key with name $value already exist');
      update();
      return;
    }
    final item = node.items.firstWhere((e) => e.hashCode == hashMap.last);
    item.name = value;
    locals.refresh();
  }

  void removeItem(List<int> hashMap, {bool update = true}) {
    LocalNode node = locals.value;
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    final item = node.items.firstWhere((e) => e.hashCode == hashMap.last);
    node.children.remove(item);
    if (update) {
      locals.refresh();
    }
  }

  void removeNode(List<int> hashMap, {bool update = true}) {
    LocalNode node = locals.value;
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    final item = node.nodes.firstWhere((e) => e.hashCode == hashMap.last);
    node.children.remove(item);
    if (update) {
      locals.refresh();
    }
  }

  Future<void> saveData() async {
    loading(true);
    Get.find<StorageService>().saveLocals(appFile, locals.value);
    loading(false);
    showNotification('Success', 'Data saved');
  }
}
