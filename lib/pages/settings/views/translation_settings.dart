import 'package:flutter/material.dart';
import '../controllers/settings_controller.dart';

class TranslationSection extends StatelessWidget {
  final SettingsController controller;
  const TranslationSection(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ExpansionTile(
        title: const Text('Translators settings'),
        children: [
          const Text('Google Api Key', style: TextStyle(fontSize: 18)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: controller.settings().tranlation.googleApi,
              obscureText: true,
              onChanged: (s) => controller.settings().tranlation.googleApi = s,
            ),
          )
        ],
      );
}
