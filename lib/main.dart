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
        brightness: Brightness.dark,
        primaryColor: const Color(0xff393e46),
        canvasColor: const Color(0xff22262b),
        scaffoldBackgroundColor: const Color(0xff22262b),
        bottomAppBarColor: const Color(0xff393e46),
        cardColor: const Color(0xff4e5258),
        dividerColor: const Color(0xff4e5258),
        hoverColor: const Color(0xff4e5258),
        highlightColor: const Color(0xffffc107),
        appBarTheme: const AppBarTheme(
          color: Color(0xff4e5258),
        ),
        toggleableActiveColor: const Color(0xffffc107),
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.amber, brightness: Brightness.dark)
            .copyWith(
          secondary: const Color(0xffffc107),
          onPrimary: Colors.white,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
	// #4e5258
	// #393e46
	// #22262b
	// #ffc107
	// #f3cc2c