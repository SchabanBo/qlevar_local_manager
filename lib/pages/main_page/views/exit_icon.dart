import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../splash_page/splash_page.dart';

class ExitIcon extends StatelessWidget {
  const ExitIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Add Language',
        onPressed: () async {
          Get.reset();
          Get.off(const SplashPage());
        },
        icon: const Icon(Icons.logout));
  }
}
