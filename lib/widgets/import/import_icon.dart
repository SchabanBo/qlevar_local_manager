import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/constants.dart';
import '../../helpers/path_picker.dart';
import '../../services/importers/json_import.dart';

class ImportIcon extends StatelessWidget {
  const ImportIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: import,
      icon: const Icon(
        Icons.download,
        color: AppColors.icon,
      ),
      tooltip: 'Import Data',
    );
  }

  void import() async {
    var path = '';
    var lan = '';
    await Get.defaultDialog(
      title: 'Import',
      middleText: 'Import language from json file',
      content: Column(
        children: [
          TextField(
            onChanged: (value) => lan = value,
            decoration: const InputDecoration(
              hintText: 'Language',
              border: OutlineInputBorder(),
            ),
          ),
          PathPicker(
            path: path,
            title: 'Select file',
            onChange: (s) => path = s,
            type: PathType.file,
          ),
        ],
      ),
      onConfirm: Get.back,
    );
    if (path.isEmpty || lan.isEmpty) {
      return;
    }

    await JsonFileImporter().import(path, lan);
  }
}
