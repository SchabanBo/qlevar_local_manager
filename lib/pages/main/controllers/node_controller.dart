import 'dart:async';

import 'package:reactive_state/reactive_state.dart';

import '../../../models/qlocal.dart';
import '../../../services/di_service.dart';
import 'main_controller.dart';

class LocalNodeController extends Controller {
  final Observable<LocalNode> item;
  final List<int> indexMap;
  final isOpen = false.asObservable;
  final _mainController = getService<MainController>();
  late final filter = _mainController.filter;

  LocalNodeController(
    LocalNode _item,
    List<int> _indexMap,
  )   : item = _item.asObservable,
        indexMap = List.from(_indexMap) {
    indexMap.add(_item.hashCode);
    _mainController.openAllNodes.addListener(nodeListener);
    if (_mainController.openAllNodes.value) {
      isOpen.value = true;
    }
  }

  Iterable<LocalBase> get children => filter.value.isEmpty
      ? item.value.children
      : item.value.children.where((i) => i.filter(filter.value));

  void nodeListener() {
    isOpen.value = _mainController.openAllNodes.value;
  }

  @override
  FutureOr onDispose() {
    _mainController.openAllNodes.removeListener(nodeListener);
    item.dispose();
    isOpen.dispose();
  }
}
