import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _textStyle = TextStyle(fontSize: 18);

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
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (c, a) => SizeTransition(
                    axisAlignment: 0,
                    axis: Axis.vertical,
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
                          style: _textStyle,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: controller.text.trim().isEmpty
                              ? Colors.red.withOpacity(0.25)
                              : null,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.text,
                          style: _textStyle,
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
