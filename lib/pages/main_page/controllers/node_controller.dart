import 'package:get/get.dart';
import 'main_controller.dart';
import '../../../models/qlocal.dart';

class LocalNodeController extends GetxController {
  final Rx<LocalNode> item;
  final List<int> indexMap;
  final Rx<bool> isOpen = false.obs;
  final _mainController = Get.find<MainController>();
  late final filter = _mainController.filter;

  @override
  void onInit() {
    super.onInit();
    _mainController.openAllNodes.listen(isOpen);
  }

  LocalNodeController(
    LocalNode _item,
    List<int> _indexMap,
  )   : item = _item.obs,
        indexMap = List.from(_indexMap) {
    indexMap.add(_item.hashCode);
  }

  Iterable<LocalBase> get children => filter.isEmpty
      ? item().children
      : item().children.where((i) => i.filter(filter()));
}
