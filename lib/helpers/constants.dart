import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  static const Duration animationDuration = Duration(milliseconds: 500);
  static const Color iconColors = Color(0xffCC9B06);
}

void showError(String title, String message) => Get.snackbar(title, message,
    colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
