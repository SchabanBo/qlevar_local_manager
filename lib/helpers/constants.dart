import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlevar_local_manager/helpers/colors.dart';

class Constants {
  static const Duration animationDuration = Duration(milliseconds: 500);
}

void showError(String title, String message) => Get.snackbar(title, message,
    backgroundColor: AppColors.secondary,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM);
