import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../settings_page/controllers/settings_controller.dart';
import '../settings_page/models/models.dart';
import '../settings_page/views/settings_view.dart';
import '../../models/qlocal.dart';
import '../../models/json/data.dart';
import '../main_page/controllers/main_controller.dart';
import '../main_page/views/main_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<Settings>(
            future: Future.delayed(
                const Duration(seconds: 1), () => SettingsLoader().load()),
            builder: (c, s) {
              if (s.hasData) {
                Get.put(SettingsController(s.data!), permanent: true);
                WidgetsBinding.instance!
                    .addPostFrameCallback((_) => selectApp());
              }
              return welcome;
            }));
  }

  Widget get welcome => Column(children: const [
        SizedBox(height: 50),
        Center(
          child: Text('Qlevar localization manager',
              style: TextStyle(fontSize: 28, color: Colors.amber)),
        ),
      ]);

  var _isBottomSheetOpen = false;

  Future<void> selectApp() async {
    if (_isBottomSheetOpen) {
      return;
    }
    _isBottomSheetOpen = true;
    final app = await Get.bottomSheet<AppLocalFile>(
      const SettingsPage(isSelectApp: true),
      enableDrag: true,
      barrierColor: Colors.transparent,
    );
    _isBottomSheetOpen = false;
    if (app == null) {
      setState(() {});
      return;
    }
    final loclas = await loadfile(app);
    if (loclas == null) {
      setState(() {});
    }
    Get.lazyPut(() => MainController(appfile: app, locals: loclas!));
    Get.offAll(() => const MainView());
  }

  Future<QlevarLocal?> loadfile(AppLocalFile appLocalFile) async {
    try {
      final file = File(appLocalFile.path);

      if (!(await file.exists())) {
        const _data = '{"en":{}}';
        await file.create(recursive: true);
        file.writeAsString(_data);
      }

      final data = await File(appLocalFile.path).readAsString();
      final l = JsonData.fromJson(data);
      return QlevarLocal.fromData(l);
    } catch (e) {
      Get.defaultDialog(
          title: 'Error reading the data', middleText: e.toString());
    }
  }
}
