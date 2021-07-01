import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_local_manager/helpers/colors.dart';

enum PathType {
  file,
  folder,
}

class PathPicker extends StatefulWidget {
  final String path;
  final void Function(String) onChange;
  final String title;
  final PathType type;
  const PathPicker({
    required this.path,
    required this.title,
    required this.onChange,
    this.type = PathType.folder,
    Key? key,
  }) : super(key: key);

  @override
  _PathPickerState createState() => _PathPickerState();
}

class _PathPickerState extends State<PathPicker> {
  late var path = widget.path;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(widget.title, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          InkWell(
              child: const Icon(
                Icons.folder,
                color: AppColors.primary,
              ),
              onTap: pick),
          const SizedBox(width: 10),
          Text(path),
        ],
      ),
    );
  }

  void pick() {
    switch (widget.type) {
      case PathType.file:
        pickFile();
        break;
      case PathType.folder:
        pickFolder();
        break;
    }
    setState(() {});
  }

  void pickFile() {
    final file = OpenFilePicker()
      ..filterSpecification = {
        'json (*.json)': '*.json',
      }
      ..defaultFilterIndex = 0
      ..defaultExtension = 'json'
      ..title = widget.title;

    final result = file.getFile();
    if (result == null) {
      return;
    }
    path = result.path;
    widget.onChange(path);
  }

  void pickFolder() {
    final file = DirectoryPicker()..title = widget.title;

    final result = file.getDirectory();
    if (result == null) {
      return;
    }
    path = result.path;
    widget.onChange(path);
  }
}
