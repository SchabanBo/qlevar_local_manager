import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'options_widget.dart';
import '../../../helpers/colors.dart';
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
        decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.1)),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        margin: const EdgeInsets.symmetric(vertical: 3.0),
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
          ],
        ),
      );

  Widget get header => Row(
        children: [
          SizedBox(width: startPadding + 8),
          OptionsWidget(controller: controller),
          const SizedBox(width: 8),
          Obx(() => Text(controller.item().key)),
          const Spacer(),
          InkWell(
              onTap: () {
                controller.isOpen.toggle();
              },
              child: Obx(() => Icon(
                    controller.isOpen.isTrue
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: AppColors.secondary,
                  ))),
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
            child: controller.isOpen.isTrue
                ? ListView(shrinkWrap: true, children: [
                    ...controller.item().items.map((e) => LocalItemBinder(
                          key: ValueKey(e.index),
                          item: e,
                          indexMap: controller.indexMap,
                          startPadding: 8 + startPadding,
                        )),
                    ...controller.item().nodes.map((e) => LocalNodeBinder(
                          key: ValueKey(e.index),
                          item: e,
                          indexMap: controller.indexMap,
                          startPadding: 8 + startPadding,
                        )),
                  ])
                : const SizedBox()),
      );
}
