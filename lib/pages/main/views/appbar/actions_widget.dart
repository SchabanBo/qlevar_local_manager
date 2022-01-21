import 'package:flutter/material.dart';
import '../../../../widgets/export/views/export_icon.dart';
import '../../../../widgets/import/import_icon.dart';

import '../../../settings/settings_icon.dart';
import '../add_language.dart';
import '../exit_icon.dart';
import '../save_data_widget.dart';
import 'expand_action.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: const [
          Spacer(),
          ExpandAction(),
          SaveDataWidget(),
          ExportIcon(),
          ImportIcon(),
          AddLanguageIcon(),
          SettingsIcon(),
          ExitIcon(),
        ],
      );
}
