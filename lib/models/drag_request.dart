import 'qlocal.dart';

abstract class DragRequest {
  String get key;
}

class ItemDragRequest extends DragRequest {
  @override
  String get key => item.key;
  final QlevarLocalItem item;
  final List<int> hashMap;
  ItemDragRequest(this.item, this.hashMap);
}

class NodeDragRequest extends DragRequest {
  @override
  String get key => node.key;
  final QlevarLocalNode node;
  final List<int> hashMap;
  NodeDragRequest(this.node, this.hashMap);
}
