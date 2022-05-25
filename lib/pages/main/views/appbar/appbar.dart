import 'package:flutter/material.dart';

import '../../../../services/di_service.dart';
import '../../controllers/main_controller.dart';
import 'actions_widget.dart';
import 'leading_actions.dart';
import 'title_widget.dart';

class QAppBar extends StatelessWidget with PreferredSizeWidget {
  final MainController mainController = getService();
  QAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF1A1A1A)),
      child: Row(
        children: const [
          Expanded(child: LeadingActions()),
          TitleWidget(),
          Expanded(child: ActionsWidget()),
        ],
      ),
    );
  }

  @override
  final preferredSize = const Size.fromHeight(60);
}
