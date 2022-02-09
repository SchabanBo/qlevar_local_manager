import 'package:flutter/material.dart';

class QNotification {
  final String message;
  final Color color;
  final bool isEmpty;

  QNotification({
    required this.message,
    required this.color,
    this.isEmpty = false,
  });

  factory QNotification.success({required String message}) =>
      QNotification(message: message, color: Colors.green);

  factory QNotification.error({required String message}) =>
      QNotification(message: message, color: Colors.red);

  factory QNotification.warning({required String message}) =>
      QNotification(message: message, color: Colors.orange);

  factory QNotification.info({required String message}) =>
      QNotification(message: message, color: Colors.blue);

  factory QNotification.neutral({required String message}) =>
      QNotification(message: message, color: Colors.grey);

  factory QNotification.empty() =>
      QNotification(message: '', color: Colors.transparent, isEmpty: true);
}
