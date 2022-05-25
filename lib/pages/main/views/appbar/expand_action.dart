import 'package:flutter/material.dart';
import 'package:reactive_state/reactive_state.dart';

import '../../../../services/di_service.dart';
import '../../controllers/main_controller.dart';

class ExpandAction extends StatelessWidget {
  const ExpandAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = getService<MainController>();
    return Observer(
        builder: (_) => IconButton(
              icon: Icon(
                controller.openAllNodes.value
                    ? Icons.unfold_less
                    : Icons.unfold_more,
              ),
              tooltip:
                  controller.openAllNodes.value ? 'Close All' : 'Expand All',
              onPressed: () =>
                  controller.openAllNodes(!controller.openAllNodes.value),
            ));
  }
}
