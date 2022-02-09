import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../models/notification.dart';
import '../../../services/storage_service.dart';
import '../../../helpers/constants.dart';
import '../../settings/models/models.dart';
import '../../../models/qlocal.dart';

class MainController extends GetxController {
  final AppLocalFile appfile;
  final Rx<QlevarLocal> locals;
  final openAllNodes = false.obs;
  final loading = false.obs;
  final filter = ''.obs;
  final notification = Rx<QNotification>(QNotification.empty());
  late final gridController = ScrollController();
  MainController({required this.appfile, required QlevarLocal locals})
      : locals = locals.obs {
    notification.listen((n) {
      if (n.isEmpty) return;
      Future.delayed(const Duration(seconds: 3), () {
        notification(QNotification.empty());
      });
    });
  }

  int get listItemsCount => locals().children.length;

  Iterable<LocalBase> get children => filter.isEmpty
      ? locals().children
      : locals().children.where((i) => i.filter(filter()));

  void addItem(List<int> hashMap, LocalItem item, {int? inserthashCode}) {
    LocalNode node = locals();
    for (var i = 1; i < hashMap.length; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    if (node.items.any((e) => e.name == item.name)) {
      showError('Error', 'Key with name ${item.name} already exist');
      return;
    }
    item.ensureAllLanguagesExist(locals().languages);
    if (item.values.entries.first.value.isEmpty) {
      item.values[locals().languages.first] = item.name;
    }

    if (inserthashCode != null) {
      node.children.insert(
          node.items.indexWhere((e) => e.hashCode == inserthashCode), item);
    } else {
      node.children.add(item);
    }

    locals.refresh();
  }

  void addNode(List<int> hashMap, LocalNode newNode, {int? inserthashCode}) {
    LocalNode node = locals();
    for (var i = 1; i < hashMap.length; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    if (node.items.any((e) => e.name == newNode.name)) {
      showError('Error', 'Key with name ${node.name} already exist');
      return;
    }
    if (inserthashCode != null) {
      node.children.insert(
          node.items.indexWhere((e) => e.hashCode == inserthashCode), newNode);
    } else {
      node.children.add(newNode);
    }
    locals.refresh();
  }

  void updateLocalItem(List<int> hashMap, String language, String value) {
    LocalNode node = locals();
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    final item = node.items.firstWhere((e) => e.hashCode == hashMap.last);
    item.values[language] = value;
    locals.refresh();
  }

  void updateLocalItemKey(List<int> hashMap, String value) {
    LocalNode node = locals();
    for (var i = 1; i < hashMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.hashCode == hashMap[i]);
    }
    if (node.items.any((e) => e.hashCode != hashMap.last && e.name == value)) {
      showError('Error', 'Key with name $value already exist');
      update();
      return;
    }
    final item = node.items.firstWhere((e) => e.hashCode == hashMap.last);
    item.name = value;
    locals.refresh();
  }

  void removeItem(List<int> hashMap, {bool update = true}) {
    LocalNode node = locals();
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
    LocalNode node = locals();
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
    Get.find<StorageService>().saveLocals(appfile, locals());
    loading(false);
    notification(QNotification.success(message: 'Data saved'));
  }

  @override
  void onClose() {
    gridController.dispose();
    super.onClose();
  }
}
