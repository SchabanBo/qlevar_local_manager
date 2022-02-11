import 'package:flutter/material.dart';
import 'package:q_overlay/q_overlay.dart';

class _Notification extends StatelessWidget {
  final String title;
  final String message;
  const _Notification(this.title, this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.headline6),
          Text(message, style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }
}

void showNotification(String title, String message) {
  QNotification(
      child: _Notification(title, message),
      backgroundDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      )).show();
}
