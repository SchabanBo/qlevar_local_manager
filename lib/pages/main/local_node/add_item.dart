import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_overlay/q_overlay.dart';

import '../../../helpers/constants.dart';
import '../../../models/qlocal.dart';
import '../controllers/main_controller.dart';

class AddLocalNode extends StatelessWidget {
  final List<int> indexMap;
  const AddLocalNode({required this.indexMap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
      child: const Tooltip(
          message: 'Add new Node',
          child: Icon(
            Icons.add_box_outlined,
            color: AppColors.icon,
          )),
      onTap: () async {
        final key = await QDialog(child: _GetItemKey()).show<String>();
        if (key == null || key.isEmpty) {
          return;
        }
        Get.find<MainController>().addNode(indexMap, LocalNode(name: key));
      });
}

class AddLocalItem extends StatelessWidget {
  final List<int> indexMap;
  const AddLocalItem({required this.indexMap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
      child: const Tooltip(
          message: 'Add new Item',
          child: Icon(
            Icons.add,
            color: AppColors.icon,
          )),
      onTap: () async {
        final key = await QDialog(child: _GetItemKey()).show<String>();
        if (key == null || key.isEmpty) {
          return;
        }
        Get.find<MainController>().addItem(indexMap, LocalItem(name: key));
      });
}

class _GetItemKey extends StatelessWidget {
  _GetItemKey({Key? key}) : super(key: key);
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add Key'),
            const SizedBox(height: 8),
            TextFormField(
              autofocus: true,
              controller: controller,
              onFieldSubmitted: (s) => submit(),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                TextButton(
                    onPressed: QOverlay.dismissLast,
                    child: const Text('Cancel')),
                const SizedBox(width: 8),
                TextButton(onPressed: submit, child: const Text('Ok')),
              ],
            )
          ],
        ),
      ),
    );
  }

  void submit() {
    if (controller.text.contains(' ')) {
      showError('Error', 'Key con not contains white spaces');
      return;
    }
    QOverlay.dismissLast(result: controller.text);
  }
}
