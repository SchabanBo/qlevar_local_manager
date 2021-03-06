import 'package:get/get.dart';

import '../../../models/drag_request.dart';
import '../../../models/qlocal.dart';
import 'main_controller.dart';

class LocalItemController extends GetxController {
  final LocalItem item;
  final List<int> indexMap;
  final MainController mainController = Get.find();
  LocalItemController(
    this.item,
    List<int> _indexMap,
  ) : indexMap = List.of(_indexMap) {
    indexMap.add(item.hashCode);
  }

  void updateValue(String language, String value) =>
      Get.find<MainController>().updateLocalItem(indexMap, language, value);

  void updateKey(String value) =>
      Get.find<MainController>().updateLocalItemKey(indexMap, value);

  void handleDrag(DragRequest request) {
    switch (request.runtimeType) {
      case ItemDragRequest:
        _handleItemDrag(request as ItemDragRequest);
        break;
      case NodeDragRequest:
        _handleNodeDrag(request as NodeDragRequest);
        break;
    }
  }

  void _handleItemDrag(ItemDragRequest request) {
    mainController.removeItem(request.hashMap, update: false);
    final map = List.of(indexMap);
    map.removeLast();
    mainController.addItem(
      map,
      request.item,
      insertHashCode: item.hashCode,
    );
  }

  void _handleNodeDrag(NodeDragRequest request) {
    mainController.removeNode(request.hashMap, update: false);
    final map = List.of(indexMap);
    map.removeLast();
    mainController.addNode(
      map,
      request.node,
      insertHashCode: item.hashCode,
    );
  }
}
