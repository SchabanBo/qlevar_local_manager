import 'package:flutter/material.dart';
import 'package:q_overlay/q_overlay.dart';

import '../../../helpers/constants.dart';
import '../../../services/di_service.dart';
import '../controllers/main_controller.dart';
import '../controllers/node_controller.dart';
import 'add_item.dart';

class OptionsWidget extends StatelessWidget {
  final LocalNodeController controller;
  const OptionsWidget({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => options;

  Widget get options => Row(
        children: [
          AddLocalNode(indexMap: controller.indexMap),
          const SizedBox(width: 5),
          AddLocalItem(indexMap: controller.indexMap),
          const SizedBox(width: 5),
          InkWell(
            child: const Tooltip(
                message: 'Delete',
                child: Icon(
                  Icons.delete_outline,
                  color: AppColors.icon,
                )),
            onTap: () => QDialog(
                child: SizedBox(
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'Are you sure you want to delete ${controller.item.value.name}?'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: QOverlay.dismissLast,
                            child: const Text('No')),
                        const SizedBox(width: 8),
                        TextButton(
                            onPressed: () {
                              getService<MainController>()
                                  .removeNode(controller.indexMap);
                              QOverlay.dismissLast();
                            },
                            child: const Text('Yes')),
                      ],
                    )
                  ],
                ),
              ),
            )).show(),
          ),
        ],
      );
}
