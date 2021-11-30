import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../local_item/editable_text_widget.dart';
import '../controllers/main_controller.dart';
import 'options_widget.dart';
import '../local_item/binder.dart';
import 'binder.dart';
import 'controller.dart';

class LocalNodeWidget extends StatelessWidget {
  final double startPadding;
  final LocalNodeController controller;
  const LocalNodeWidget(
      {required this.controller, this.startPadding = 0, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(left: startPadding),
        decoration: BoxDecoration(
          color: Get.theme.bottomAppBarColor.withOpacity(0.2),
          border: Border(
            left: BorderSide(
              color: Colors.blueGrey.shade300,
            ),
            bottom: BorderSide(
              color: Colors.blueGrey.shade300,
            ),
          ),
        ),
        child: Obx(() => Column(
              children: [
                header,
                body,
              ],
            )),
      );

  Widget get header => Container(
        color: Get.theme.bottomAppBarColor,
        child: Row(
          children: [
            const SizedBox(width: 8),
            Flexible(
              flex: 1,
              child: QEditableText(
                  text: controller.item().key,
                  onEdit: (s) => controller.item().key = s),
            ),
            Expanded(
              flex: Get.find<MainController>().locals().languages.length,
              child: InkWell(
                onTap: () {
                  controller.item.value.isOpen.toggle();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() => Icon(
                        controller.item.value.isOpen.isTrue
                            ? Icons.expand_less
                            : Icons.expand_more,
                        size: 30,
                      )),
                ),
              ),
            ),
            const SizedBox(width: 5),
            OptionsWidget(controller: controller),
            const SizedBox(width: 8),
          ],
        ),
      );

  Widget get body => AnimatedSwitcher(
        switchInCurve: Curves.linearToEaseOut,
        switchOutCurve: Curves.linearToEaseOut,
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (c, a) =>
            SizeTransition(sizeFactor: a, child: c, axis: Axis.vertical),
        child: controller.item.value.isOpen.isTrue
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                    ...controller.getItem.map((e) => LocalItemBinder(
                          key: ValueKey(e.index),
                          item: e,
                          indexMap: controller.indexMap,
                          startPadding: 8 + startPadding,
                        )),
                    ...controller.getNodes.map((e) => LocalNodeBinder(
                          key: ValueKey(e.index),
                          item: e,
                          indexMap: controller.indexMap,
                          startPadding: 8 + startPadding,
                        )),
                  ])
            : const SizedBox(),
      );
}
