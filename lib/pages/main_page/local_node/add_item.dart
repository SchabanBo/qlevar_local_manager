import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlevar_local_manager/helpers/constants.dart';
import '../controllers/main_controller.dart';

class AddLocalNode extends StatelessWidget {
  final List<int> indexMap;
  const AddLocalNode({required this.indexMap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
      child: const Tooltip(
          message: 'Add new Node',
          child: Icon(
            Icons.add_box,
            color: Colors.blue,
          )),
      onTap: () async {
        final key = await Get.dialog<String>(_GetItemKey());
        if (key == null || key.isEmpty) {
          return;
        }
        Get.find<MainController>().addNode(indexMap, key);
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
            color: Colors.blue,
          )),
      onTap: () async {
        final key = await Get.dialog<String>(_GetItemKey());
        if (key == null || key.isEmpty) {
          return;
        }
        Get.find<MainController>().addItem(indexMap, key);
      });
}

class _GetItemKey extends StatelessWidget {
  _GetItemKey({Key? key}) : super(key: key);
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Key'),
      content: TextFormField(
        autofocus: true,
        controller: controller,
        onFieldSubmitted: (s) => submit(),
      ),
      actions: [
        ElevatedButton(onPressed: Get.back, child: const Text('Cancel')),
        ElevatedButton(onPressed: submit, child: const Text('Ok')),
      ],
    );
  }

  void submit() {
    if (controller.text.contains(' ')) {
      showError('Error', 'Key con not conains white spaces');
      return;
    }
    Get.back<String>(result: controller.text);
  }
}
