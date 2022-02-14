import 'package:flutter/material.dart';
import '../../../../widgets/export/views/export_icon.dart';
import '../../../../widgets/import/import_icon.dart';

import '../../../settings/settings_icon.dart';
import '../../../languages/views/language_icon.dart';
import 'exit_icon.dart';
import 'save_data_widget.dart';
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
          LanguageSettings(),
          SettingsIcon(),
          ExitIcon(),
        ],
      );
}
