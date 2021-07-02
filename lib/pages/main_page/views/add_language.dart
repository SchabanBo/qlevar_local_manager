import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class AddLanguageIcon extends StatelessWidget {
  const AddLanguageIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Add Language',
        onPressed: () async {
          final value = await Get.dialog<String>(_GetLanguage());
          if (value == null || value.isEmpty) {
            return;
          }
          final con = Get.find<MainController>();
          con.locals().languages.add(value);
          con.locals().ensureAllLanguagesExist(con.locals().languages);
          con.locals.refresh();
        },
        icon: const Icon(Icons.language));
  }
}

class _GetLanguage extends StatelessWidget {
  _GetLanguage({Key? key}) : super(key: key);
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(controller: controller),
          const Text('Ex. [en] [en_US] [ar] [de]'),
        ],
      ),
      actions: [
        ElevatedButton(onPressed: Get.back, child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              Get.back<String>(result: controller.text);
            },
            child: const Text('Ok')),
      ],
    );
  }
}
