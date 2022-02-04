import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/constants.dart';
import '../../services/storage_service.dart';
import '../settings/controllers/settings_controller.dart';
import '../settings/models/models.dart';
import '../settings/views/settings_view.dart';
import '../main/controllers/main_controller.dart';
import '../main/views/main_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final StorageService _storageController = Get.find<StorageService>();

  final Widget welcome = Column(children: const [
    SizedBox(height: 50),
    Center(
      child: Text('Qlevar localization manager',
          style: TextStyle(
            fontSize: 28,
            color: Colors.amber,
          )),
    ),
  ]);

  var _isBottomSheetOpen = false;

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
                    .addPostFrameCallback((_) => selectApp());
              }
              return welcome;
            }));
  }

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
    final loclas = await _storageController.loadLocals(app);
    if (loclas == null) {
      setState(() {});
      return;
    }
    Get.lazyPut(() => MainController(appfile: app, locals: loclas));
    Get.offAll(() => const MainView());
  }
}
