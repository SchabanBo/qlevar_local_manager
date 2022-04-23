import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_overlay/q_overlay.dart';

import 'pages/splash/splash_page.dart';
import 'services/storage_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(StorageService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<NavigatorState>();
    QOverlay.navigationKey = key;
    return MaterialApp(
      title: 'Qlevar Local Manager',
      navigatorKey: key,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: const Color(0xFF212121),
        canvasColor: const Color(0xFF212121),
        colorScheme:
            ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
          secondary: const Color(0xffB7B327),
          primary: Colors.amber,
        ),
        toggleableActiveColor: Colors.amber,
      ),
      home: const SplashPage(),
    );
  }
}
