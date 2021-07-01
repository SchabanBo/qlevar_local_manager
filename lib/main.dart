import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helpers/colors.dart';
import 'pages/splash_page/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Qlevar Local Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary),
          colorScheme: const ColorScheme.light().copyWith(
              primary: AppColors.primary, secondary: AppColors.secondary)),
      home: const SplashPage(),
    );
  }
}
