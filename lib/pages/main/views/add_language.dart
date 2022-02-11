import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_overlay/q_overlay.dart';
import '../../../helpers/constants.dart';
import '../controllers/main_controller.dart';

class AddLanguageIcon extends StatelessWidget {
  const AddLanguageIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Add Language',
        onPressed: () async {
          final value = await QPanel(
            width: 200,
            child: _GetLanguage(),
            alignment: Alignment.center,
          ).show<String>();
          if (value == null || value.isEmpty) return;
          final con = Get.find<MainController>();
          con.locals().languages.add(value);
          con.locals().ensureAllLanguagesExist(con.locals().languages);
          con.locals.refresh();
        },
        icon: const Icon(
          Icons.language,
          color: AppColors.icon,
        ));
  }
}

class _GetLanguage extends StatelessWidget {
  _GetLanguage({Key? key}) : super(key: key);
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add Language'),
          TextFormField(controller: controller),
          const Text('Ex. [en] [en_US] [ar] [de]'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              TextButton(
                  onPressed: QOverlay.dismissLast, child: const Text('Cancel')),
              const SizedBox(width: 8),
              TextButton(
                  onPressed: () {
                    QOverlay.dismissLast<String>(result: controller.text);
                  },
                  child: const Text('Ok')),
            ],
          )
        ],
      ),
    );
  }
}
