import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  static const Duration animationDuration = Duration(milliseconds: 500);
  static const Color iconColors = Colors.grey;
}

void showError(String title, String message) => Get.snackbar(title, message,
    colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
