import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_controller.dart';
import 'leading_Actions.dart';
import 'actions_widget.dart';
import 'title_widget.dart';

class QAppBar extends StatelessWidget with PreferredSizeWidget {
  final MainController mainController = Get.find();
  QAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black, boxShadow: [
        BoxShadow(color: Colors.white24, blurRadius: 5, spreadRadius: 5),
      ]),
      child: Row(
        children: [
          const Expanded(child: LeadingActions()),
          TitleWidget(),
          const Expanded(child: ActionsWidget()),
        ],
      ),
    );
  }

  @override
  final preferredSize = const Size.fromHeight(60);
}
