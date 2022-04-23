import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import '../../helpers/path_picker.dart';
import '../../services/importers/json_import.dart';

class ImportIcon extends StatelessWidget {
  const ImportIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => import(context),
      icon: const Icon(
        Icons.download,
        color: AppColors.icon,
      ),
      tooltip: 'Import Data',
    );
  }

  void import(BuildContext context) async {
    var path = '';
    var lan = '';

    await showDialog(
        context: context,
        builder: (c) => AlertDialog(
              title: const Text('Import language from json file'),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
              ]),
              actions: [
                TextButton(
                    onPressed: () {
                      lan = '';
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Import'))
              ],
            ));

    if (path.isEmpty || lan.isEmpty) {
      return;
    }

    await JsonFileImporter().import(path, lan);
  }
}
