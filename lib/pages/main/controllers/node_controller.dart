import 'package:get/get.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../../models/qlocal.dart';
import 'main_controller.dart';

class LocalNodeController extends GetxController {
  final Observable<LocalNode> item;
  final List<int> indexMap;
  final isOpen = false.asObservable;
  final _mainController = Get.find<MainController>();
  late final filter = _mainController.filter;

  @override
  void onInit() {
    super.onInit();
    _mainController.openAllNodes.addListener(() {
      isOpen.value = _mainController.openAllNodes.value;
    });
    if (_mainController.openAllNodes.value) {
      isOpen.value = true;
    }
  }

  LocalNodeController(
    LocalNode _item,
    List<int> _indexMap,
  )   : item = _item.asObservable,
        indexMap = List.from(_indexMap) {
    indexMap.add(_item.hashCode);
  }

  Iterable<LocalBase> get children => filter.value.isEmpty
      ? item.value.children
      : item.value.children.where((i) => i.filter(filter.value));
}
