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
        color: Get.theme.bottomAppBarColor.withOpacity(0.1),
        child: Column(
          children: [
            Obx(() => Row(
                  children: [
                    Expanded(flex: 2, child: header),
                    ...List.generate(
                        Get.find<MainController>().locals().languages.length,
                        (i) => i).map((_) => const Expanded(child: SizedBox()))
                  ],
                )),
            body,
            const Divider(),
          ],
        ),
      );

  Widget get header => Row(
        children: [
          const SizedBox(width: 8),
          QEditableText(
              text: controller.item().key,
              onEdit: (s) => controller.item().key = s),
          const Spacer(),
          InkWell(
              onTap: () {
                controller.item.value.isOpen.toggle();
              },
              child: Obx(() => Icon(
                    controller.item.value.isOpen.isTrue
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 30,
                  ))),
          SizedBox(width: startPadding + 8),
          OptionsWidget(controller: controller),
          const SizedBox(width: 25),
        ],
      );

  Widget get body => Obx(
        () => AnimatedSwitcher(
            switchInCurve: Curves.linearToEaseOut,
            switchOutCurve: Curves.linearToEaseOut,
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (c, a) => SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, -1), end: const Offset(0, 0))
                    .animate(a),
                child: FadeTransition(
                    opacity: a,
                    child: SizeTransition(sizeFactor: a, child: c))),
            child: controller.item.value.isOpen.isTrue
                ? ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
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
                : const SizedBox()),
      );
}
