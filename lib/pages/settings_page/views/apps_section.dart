import 'package:flutter/material.dart';
import '../../../helpers/path_picker.dart';
import '../controllers/settings_controller.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class AppsSection extends StatefulWidget {
  final SettingsController controller;
  final bool isSelectApp;
  const AppsSection(this.controller, this.isSelectApp, {Key? key})
      : super(key: key);

  @override
  State<AppsSection> createState() => _AppsSectionState();
}

class _AppsSectionState extends State<AppsSection> {
  late final SettingsController controller = widget.controller;
  var addNewApp = false;
  @override
  Widget build(BuildContext context) => ExpansionTile(
        title: const Text('Apps settings'),
        initiallyExpanded: widget.isSelectApp,
        children: [
          addNewAppWidget,
          const SizedBox(height: 10),
          controller.settings().apps.isEmpty
              ? const Center(
                  child: Text('Add your first app :)',
                      style: TextStyle(fontSize: 18)))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.controller.settings().apps.length,
                  itemBuilder: (c, i) {
                    final app = widget.controller.settings().apps[i];
                    return ListTile(
                      title: Text(app.name),
                      subtitle: Text(app.path),
                      trailing: InkWell(
                        onTap: () {
                          controller.settings().apps.remove(app);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () => Get.back<AppLocalFile>(result: app),
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
          ? getAddNewWidget
          : ElevatedButton(
              onPressed: () {
                setState(() {
                  addNewApp = true;
                });
              },
              child: const Text('Add new app')));

  Widget get getAddNewWidget {
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
                    if (widget.controller
                        .settings()
                        .apps
                        .any((e) => e.name == s)) {
                      return 'App already exist';
                    }
                    return null;
                  },
                ),
              ),
              TextButton(
                  onPressed: () async {
                    if (appPath.isEmpty) {
                      Get.defaultDialog(
                          title: 'Error', middleText: 'you must set the path');
                      return;
                    }
                    appPath += '/qlevar_local_manager.json';
                    if (key.currentState!.validate()) {
                      widget.controller.settings().apps.add(AppLocalFile(
                            name: appName.text,
                            path: appPath,
                            exportPath: appExportPath,
                          ));
                      widget.controller.save();
                      addNewApp = false;
                      setState(() {});
                    }
                  },
                  child: const Text('Add')),
              TextButton(
                  onPressed: () {
                    addNewApp = false;
                    setState(() {});
                  },
                  child: const Text('Cancel'))
            ],
          ),
          PathPicker(
              path: appPath,
              title: 'Pick where to save the data',
              onChange: (s) => appPath = s),
          PathPicker(
              path: appExportPath,
              title: 'Pick where to export the data',
              onChange: (s) => appExportPath = s),
        ],
      ),
    );
  }
}
