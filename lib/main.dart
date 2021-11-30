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
        colorScheme:
            ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
          secondary: const Color(0xffCC9B06),
          primary: Colors.blueGrey.shade300,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
	// #4e5258
	// #393e46
	// #22262b


// #806104
// #FFD454
// #ffc107
// #806A2A
// #CC9B06