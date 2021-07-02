import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/path_picker.dart';
import '../../services/importers/json_import.dart';

class ImportIcon extends StatelessWidget {
  const ImportIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: import,
      icon: const Icon(Icons.download),
      tooltip: 'Import Data',
    );
  }

  void import() async {
    var path = '';
    await Get.defaultDialog(
        title: 'Import',
        middleText: 'Import language from json file',
        content: PathPicker(
          path: path,
          title: 'Select file',
          onChange: (s) => path = s,
          type: PathType.file,
        ),
        onConfirm: () => Get.back());
    if (path.isEmpty) {
      return;
    }
    final name =
        path.substring(path.lastIndexOf('\\') + 1).replaceAll('.json', '');
    await JsonFileImporter().import(path, name);
  }
}
