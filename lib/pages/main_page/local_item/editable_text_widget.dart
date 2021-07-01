import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QEditableText extends StatelessWidget {
  final String text;
  final Function(String) onEdit;
  late final controller = TextEditingController(text: text);
  QEditableText({required this.text, required this.onEdit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
        (edit) => edit.isTrue
            ? Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: controller,
                    maxLines: null,
                    onFieldSubmitted: (s) => save(edit),
                  ),
                  const SizedBox(height: 5),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    InkWell(
                      onTap: () => save(edit),
                      child: const Icon(Icons.done, color: Colors.green),
                    ),
                    InkWell(
                      onTap: () => edit.toggle(),
                      child: const Icon(Icons.close, color: Colors.red),
                    )
                  ])
                ],
              )
            : InkWell(onTap: () => edit.toggle(), child: Text(text)),
        false.obs);
  }

  void save(RxBool edit) {
    onEdit(controller.text);
    edit.toggle();
  }
}
