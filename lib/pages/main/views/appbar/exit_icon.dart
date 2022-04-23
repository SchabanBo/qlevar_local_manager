import 'package:flutter/material.dart';

import '../../../../helpers/constants.dart';
import '../../../splash/splash_page.dart';

class ExitIcon extends StatelessWidget {
  const ExitIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Exit App',
        onPressed: () {
          final route = MaterialPageRoute(builder: (_) => const SplashPage());
          Navigator.pushReplacement(context, route);
        },
        icon: const Icon(
          Icons.logout,
          color: AppColors.icon,
        ));
  }
}
