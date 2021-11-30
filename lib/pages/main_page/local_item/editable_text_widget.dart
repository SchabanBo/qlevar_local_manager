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
        (edit) => InkWell(
            onTap: () => edit.toggle(),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (c, a) => SizeTransition(
                    axisAlignment: 1,
                    axis: Axis.horizontal,
                    sizeFactor: CurvedAnimation(
                        parent: a, curve: Curves.linearToEaseOut),
                    child: c),
                child: edit.isTrue
                    ? Focus(
                        onFocusChange: (f) {
                          if (!f) {
                            save(edit);
                          }
                        },
                        child: TextField(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0), filled: true),
                          autofocus: true,
                          maxLines: null,
                          controller: controller,
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: controller.text.trim().isEmpty
                              ? Colors.red.withOpacity(0.3)
                              : null,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.text,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
              ),
            )),
        false.obs);
  }

  void save(RxBool edit) {
    onEdit(controller.text);
    edit.toggle();
  }
}
