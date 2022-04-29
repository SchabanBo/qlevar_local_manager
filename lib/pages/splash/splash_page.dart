import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:q_overlay/q_overlay.dart';

import '../../helpers/constants.dart';
import '../../services/storage_service.dart';
import '../main/controllers/main_controller.dart';
import '../main/views/main_view.dart';
import '../settings/controllers/settings_controller.dart';
import '../settings/models/models.dart';
import '../settings/views/settings_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final StorageService _storageController = Get.find<StorageService>();

  final Widget welcome = Column(
    children: const [
      SizedBox(height: 50),
      Center(
        child: Text(
          'Qlevar localization manager',
          style: TextStyle(
            fontSize: 28,
            color: Colors.amber,
          ),
        ),
      ),
    ],
  );

  var _isPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.node,
      body: FutureBuilder<Settings>(
        future: Future.delayed(const Duration(seconds: 1),
            () => _storageController.loadSettings()),
        builder: (c, s) {
          if (s.hasData) {
            Get.put(SettingsController(s.data!), permanent: true);
            WidgetsBinding.instance
                .addPostFrameCallback((_) => selectApp(context));
          }
          return welcome;
        },
      ),
    );
  }

  Future<void> selectApp(BuildContext context) async {
    if (_isPanelOpen) {
      return;
    }
    _isPanelOpen = true;
    final app = await QPanel(
      child: const SettingsPage(isSelectApp: true),
      backgroundFilter: const BackgroundFilterSettings(
        color: Colors.transparent,
        blurX: 0.001,
        blurY: 0.001,
      ),
    ).show<AppLocalFile>();
    _isPanelOpen = false;
    if (app == null) {
      setState(() {});
      return;
    }
    final locals = await _storageController.loadLocals(app);
    if (locals == null) {
      setState(() {});
      return;
    }
    await Get.delete<MainController>();
    Get.put(MainController(appFile: app, locals: locals));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const MainView()));
  }
}
