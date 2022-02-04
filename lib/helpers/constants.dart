import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static const Color icon = Colors.white;
  static const Color border = Color(0xFF525252);
  static const Color node = Color(0xFF2C2C2D);
  static const Color drag = Color(0xFF101010);
  static const Color secondary = Color(0xffB7B327);
  static const Color primary = Colors.amber;
}

void showError(String title, String message) => Get.snackbar(title, message,
    colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
