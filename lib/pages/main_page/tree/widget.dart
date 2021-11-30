import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../views/options_row.dart';
import '../../../models/qlocal.dart';
import '../../../widgets/rotaion_icon.dart';

class TreeWidget extends StatelessWidget {
  final QlevarLocalNode node;

  const TreeWidget(
    this.node, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OptionsRow(),
          Expanded(
            child: node.hasChildren
                ? TreeChildren(node, isParent: true)
                : const SizedBox.shrink(),
          ),
        ],
      );
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
            node.hasChildren ? TreeChildren(node) : const SizedBox.shrink()
          ],
        ),
      );
}

class TreeChildren extends StatelessWidget {
  final QlevarLocalNode node;
  final bool isParent;
  const TreeChildren(this.node, {this.isParent = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(() => AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: node.isOpen.value
          ? ListView(
              shrinkWrap: !isParent,
              physics: isParent ? null : const NeverScrollableScrollPhysics(),
              controller:
                  isParent ? Get.find<MainController>().treeController : null,
              children: _getChildren(node))
          : const SizedBox.shrink()));

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
}
