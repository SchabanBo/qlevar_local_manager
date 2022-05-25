import 'package:flutter/material.dart';
import 'package:reactive_state/reactive_state.dart';

const _textStyle = TextStyle(fontSize: 18);

class QEditableText extends StatelessWidget {
  final String text;
  final Function(String) onEdit;
  late final controller = TextEditingController(text: text);
  QEditableText({required this.text, required this.onEdit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueObserver<bool>(
      initData: false,
      builder: (_, edit) => InkWell(
          onDoubleTap: () {
            edit(!edit.value);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (c, a) => SizeTransition(
                  axisAlignment: 0,
                  axis: Axis.vertical,
                  sizeFactor:
                      CurvedAnimation(parent: a, curve: Curves.linearToEaseOut),
                  child: c),
              child: edit.value
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
                        onSubmitted: (_) => save(edit),
                        style: _textStyle,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: controller.text.trim().isEmpty
                            ? Colors.red.withOpacity(0.5)
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
    );
  }

  void save(Observable<bool> edit) {
    onEdit(controller.text);
    edit(!edit.value);
  }
}
