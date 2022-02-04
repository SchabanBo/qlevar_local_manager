import 'qlocal.dart';

abstract class DragRequest {
  String get key;
}

class ItemDragRequest extends DragRequest {
  @override
  String get key => item.name;
  final LocalItem item;
  final List<int> hashMap;
  ItemDragRequest(this.item, this.hashMap);
}

class NodeDragRequest extends DragRequest {
  @override
  String get key => node.name;
  final LocalNode node;
  final List<int> hashMap;
  NodeDragRequest(this.node, this.hashMap);
}
