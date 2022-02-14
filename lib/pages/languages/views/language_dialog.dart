import 'package:flutter/material.dart';
import 'package:q_overlay/q_overlay.dart';

class LanguageDialog extends StatelessWidget {
  final TextEditingController controller;
  LanguageDialog({String? value = '', Key? key})
      : controller = TextEditingController(text: value),
        super(key: key);
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
