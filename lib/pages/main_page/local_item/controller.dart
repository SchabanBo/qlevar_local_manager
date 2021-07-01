import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../../../models/qlocal.dart';

class LocalItemController extends GetxController {
  final QlevarLocalItem item;
  final List<int> indexMap;

  LocalItemController(
    this.item,
    List<int> _indexMap,
  ) : indexMap = List.of(_indexMap) {
    indexMap.add(item.index);
  }

  void updateValue(String language, String value) =>
      Get.find<MainController>().updateLocalItem(indexMap, language, value);

  void updateKey(String value) =>
      Get.find<MainController>().updateLocalItemKey(indexMap, value);
}
