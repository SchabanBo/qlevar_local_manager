import 'package:flutter/material.dart';
import 'package:q_overlay/q_overlay.dart';

import '../../helpers/constants.dart';
import '../../services/di_service.dart';
import '../../services/storage_service.dart';
import '../main/controllers/main_controller.dart';
import '../main/views/main_view.dart';
import '../settings/controllers/settings_controller.dart';
import '../settings/models/models.dart';
import '../settings/views/settings_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final StorageService _storageController = getService<StorageService>();

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
            if (!isServiceRegistered<SettingsController>()) {
              addService(SettingsController(s.data!));
            }
            WidgetsBinding.instance
                .addPostFrameCallback((_) => selectApp(Navigator.of(context)));
          }
          return welcome;
        },
      ),
    );
  }

  Future<void> selectApp(NavigatorState navigator) async {
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
    if (isServiceRegistered<MainController>()) removeService<MainController>();
    addService(MainController(appFile: app, locals: locals));
    navigator.pushReplacement(MaterialPageRoute(
      builder: (_) => const MainView(),
    ));
  }
}
