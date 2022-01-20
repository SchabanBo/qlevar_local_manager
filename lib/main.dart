import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        backgroundColor: const Color(0xFF212121),
        canvasColor: const Color(0xFF212121),
        appBarTheme:
            const AppBarTheme(color: Colors.black, shadowColor: Colors.white30),
        colorScheme:
            ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
          secondary: const Color(0xffB7B327),
          primary: Colors.amber,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
