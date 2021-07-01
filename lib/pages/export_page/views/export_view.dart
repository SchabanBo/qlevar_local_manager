import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/path_picker.dart';
import '../../main_page/controllers/main_controller.dart';
import '../../../services/exporters/getx_exporter_servvice.dart';

class ExportView extends StatelessWidget {
  final String path;
  const ExportView({required this.path, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _path = path;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Export Data', style: TextStyle(fontSize: 24)),
            const Divider(),
            PathPicker(
                path: path,
                title: 'Give the directory path to export to',
                onChange: (s) => _path = s),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  final data = Get.find<MainController>().locals().toData();
                  GetxExporterService(data: data)
                      .export(_path + '/locals.dart');
                  Get.back();
                },
                child: const Text('Export')),
          ],
        ),
      ),
    );
  }
}
