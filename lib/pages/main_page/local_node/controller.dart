import 'package:get/get.dart';
import '../../../models/qlocal.dart';

class LocalNodeController extends GetxController {
  final isOpen = false.obs;
  final Rx<QlevarLocalNode> item;
  final List<int> indexMap;

  LocalNodeController(
    QlevarLocalNode _item,
    List<int> _indexMap,
  )   : item = _item.obs,
        indexMap = List.from(_indexMap) {
    indexMap.add(_item.index);
  }
}
