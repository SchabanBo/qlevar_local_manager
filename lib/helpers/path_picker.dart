import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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

  Future pickFile() async {
    final file = await FilePicker.platform.pickFiles(
      dialogTitle: widget.title,
      type: FileType.custom,
      allowedExtensions: ['[json]'],
    );

    if (file?.paths.isEmpty ?? true) {
      return;
    }

    final result = file!.paths.first;
    if (result == null) {
      return;
    }
    path = result;
    widget.onChange(path);
  }

  Future pickFolder() async {
    final result =
        await FilePicker.platform.getDirectoryPath(dialogTitle: widget.title);
    if (result == null) {
      return;
    }
    path = result;
    widget.onChange(path);
  }
}
