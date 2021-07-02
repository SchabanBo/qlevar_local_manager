import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'export_view.dart';

class ExportIcon extends StatelessWidget {
  const ExportIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.bottomSheet(ExportView()),
      icon: const Icon(Icons.upload),
      tooltip: 'Export Data',
    );
  }
}
