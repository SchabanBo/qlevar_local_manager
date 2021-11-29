import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/options_row.dart';
import '../../../models/qlocal.dart';
import '../../../widgets/rotaion_icon.dart';

// void scrollTo(JsonNode node) {
//   final index = 45 * getOpenItemsCount(nodes, node);
//   widget.editorController.animateTo(index.toDouble(),
//       duration: const Duration(milliseconds: 400), curve: Curves.easeInExpo);
//   node.state.togglehighlight();
// }

// int getOpenItemsCount(List<JsonNode> searchIn, JsonNode node) {
//   if (searchIn.contains(node)) {
//     return searchIn.indexOf(node);
//   }
//   var result = 0;
//   for (var parent in searchIn) {
//     if (parent.hasChidren && parent.state.isOpen) {
//       if (parent.contains(node)) {
//         result += getOpenItemsCount(parent.children, node);
//         if (parent.children.contains(node)) {
//           break;
//         }
//       } else {
//         result += parent.openChildrenLength();
//       }
//     } else {
//       result++;
//     }
//   }
//   return result;
// }

class TreeWidget extends StatelessWidget {
  final QlevarLocalNode node;

  const TreeWidget(
    this.node, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: node.hasChildren ? children : const SizedBox.shrink(),
        ),
      );

  Widget get children => Obx(() => AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: node.isOpen.value
          ? ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [OptionsRow(), ..._getChildren(node)])
          : const SizedBox.shrink()));
}

List<Widget> _getChildren(QlevarLocalNode node) {
  final result = <Widget>[];
  for (var item in node.items) {
    result.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(item.key.toUpperCase()),
      ),
    );
  }
  for (var item in node.nodes) {
    result.add(_TreeWidget(item));
  }
  return result;
}

class _TreeWidget extends StatelessWidget {
  final QlevarLocalNode node;

  const _TreeWidget(
    this.node, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 8, top: 1),
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.amber,
              width: 2,
            ),
          ),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: node.isOpen.toggle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(node.key.toUpperCase()),
                    node.hasChildren
                        ? Obx(() => RotaionIcon(rotate: !node.isOpen.value))
                        : const SizedBox()
                  ],
                ),
              ),
            ),
            node.hasChildren ? children : const SizedBox.shrink()
          ],
        ),
      );

  Widget get children => Obx(() => AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: node.isOpen.value
          ? ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _getChildren(node))
          : const SizedBox.shrink()));
}
