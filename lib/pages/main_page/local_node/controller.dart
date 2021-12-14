import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../../../models/qlocal.dart';

class LocalNodeController extends GetxController {
  final Rx<QlevarLocalNode> item;
  late final filter = _mainController.filter;
  final List<int> indexMap;
  final _mainController = Get.find<MainController>();

  @override
  void onInit() {
    super.onInit();
    _mainController.openAllNodes.listen(item.value.isOpen);
  }

  LocalNodeController(
    QlevarLocalNode _item,
    List<int> _indexMap,
  )   : item = _item.obs,
        indexMap = List.from(_indexMap) {
    indexMap.add(_item.hashCode);
  }

  Iterable<QlevarLocalItem> get getItem => filter.isEmpty
      ? item().items
      : item().items.where((i) => i.filter(filter()));

  Iterable<QlevarLocalNode> get getNodes => filter.isEmpty
      ? item().nodes
      : item().nodes.where((i) => i.filter(filter()));
}
