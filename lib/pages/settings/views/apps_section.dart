import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:q_overlay/q_overlay.dart';
import '../../../helpers/constants.dart';
import '../../../services/storage_service.dart';
import '../../../helpers/path_picker.dart';
import '../controllers/settings_controller.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class AppsSection extends StatefulWidget {
  final bool isSelectApp;
  const AppsSection(this.isSelectApp, {Key? key}) : super(key: key);

  @override
  State<AppsSection> createState() => _AppsSectionState();
}

class _AppsSectionState extends State<AppsSection> {
  final SettingsController controller = Get.find();
  var addNewApp = false;
  @override
  Widget build(BuildContext context) => ExpansionTile(
        title: const Text('Apps settings'),
        initiallyExpanded: widget.isSelectApp,
        children: [
          kIsWeb
              ? Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: _openAppFromFile,
                    child: const Text('Import app from file'),
                  ),
                )
              : const SizedBox.shrink(),
          addNewAppWidget,
          const SizedBox(height: 10),
          controller.settings().apps.isEmpty
              ? const Center(
                  child: Text('Add your first app :)',
                      style: TextStyle(fontSize: 18)))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.settings().apps.length,
                  itemBuilder: (c, i) {
                    final app = controller.settings().apps[i];
                    return Card(
                      child: ListTile(
                        title: Text(app.name),
                        subtitle: kIsWeb ? null : Text(app.path),
                        trailing: InkWell(
                          onTap: () {
                            controller.settings().apps.remove(app);
                            setState(() {});
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                        onTap: () =>
                            QOverlay.dismissLast<AppLocalFile>(result: app),
                      ),
                    );
                  }),
        ],
      );

  Widget get addNewAppWidget => AnimatedSwitcher(
      switchInCurve: Curves.easeOutExpo,
      layoutBuilder: (c, _) => Align(alignment: Alignment.centerLeft, child: c),
      transitionBuilder: (c, a) => SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
                  .animate(a),
          child: ScaleTransition(child: c, scale: a)),
      duration: const Duration(milliseconds: 800),
      child: addNewApp
          ? AddNewAppWidget(() {
              addNewApp = false;
              setState(() {});
            })
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      addNewApp = true;
                    });
                  },
                  child: const Text('Add new app')),
            ));

  void _openAppFromFile() async {
    var data = '';
    var appName = '';

    await showDialog(
        context: context,
        builder: (c) => AlertDialog(
              title: const Text('Import Data'),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const Text('Import language from json file'),
                TextField(
                  onChanged: (value) => appName = value,
                  decoration: const InputDecoration(
                    hintText: 'App Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                PathPicker(
                  path: data,
                  title: 'Select file',
                  onChange: (s) => data = s,
                  type: PathType.file,
                ),
              ]),
              actions: [
                TextButton(
                    onPressed: () {
                      data = '';
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Import'))
              ],
            ));

    if (data.isEmpty || appName.isEmpty) return;
    final app = AppLocalFile(
      name: appName,
      path: '',
      exportPath: '',
    );
    controller.settings().apps.add(app);
    Get.find<StorageService>().saveSettings(controller.settings.value);
    await Get.find<StorageService>().importLocalsWeb(appName, data);
    QOverlay.dismissLast<AppLocalFile>(result: app);
  }
}

class AddNewAppWidget extends GetView<SettingsController> {
  final VoidCallback onEnd;
  const AddNewAppWidget(this.onEnd, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    final appName = TextEditingController();
    var appPath = '';
    var appExportPath = '';
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: appName,
                  decoration: const InputDecoration(hintText: 'App Name'),
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Name required';
                    if (controller.settings().apps.any((e) => e.name == s)) {
                      return 'App already exist';
                    }
                    return null;
                  },
                ),
              ),
              TextButton(
                  onPressed: () async {
                    if (appPath.isEmpty && !kIsWeb) {
                      Get.defaultDialog(
                          title: 'Error', middleText: 'you must set the path');
                      return;
                    }
                    if (key.currentState!.validate()) {
                      controller.settings().apps.add(AppLocalFile(
                            name: appName.text,
                            path: appPath,
                            exportPath: appExportPath,
                          ));
                      Get.find<StorageService>()
                          .saveSettings(controller.settings.value);
                      onEnd();
                    }
                  },
                  child: const Text('Add')),
              TextButton(onPressed: onEnd, child: const Text('Cancel'))
            ],
          ),
          kIsWeb
              ? const SizedBox.shrink()
              : PathPicker(
                  path: appPath,
                  title: 'Pick where to save the data',
                  type: PathType.file,
                  onChange: (s) => appPath = s),
          kIsWeb
              ? const SizedBox.shrink()
              : PathPicker(
                  path: appExportPath,
                  title: 'Pick where to export the data',
                  onChange: (s) => appExportPath = s),
        ],
      ),
    );
  }
}
