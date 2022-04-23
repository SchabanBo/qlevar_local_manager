import 'package:flutter/material.dart';
import '../../../helpers/constants.dart';
import 'export_view.dart';

class ExportIcon extends StatelessWidget {
  const ExportIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (_) => ExportView(),
      ),
      icon: const Icon(
        Icons.upload,
        color: AppColors.icon,
      ),
      tooltip: 'Export Data',
    );
  }
}
