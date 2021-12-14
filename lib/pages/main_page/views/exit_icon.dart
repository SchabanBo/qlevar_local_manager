import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../splash_page/splash_page.dart';
import '../controllers/main_controller.dart';

class ExitIcon extends StatelessWidget {
  const ExitIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Exit App',
        onPressed: () async {
          Get.delete<MainController>();
          Get.offAll(() => const SplashPage());
        },
        icon: const Icon(Icons.logout));
  }
}
