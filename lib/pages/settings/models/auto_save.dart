import 'dart:convert';

import '../../../widgets/export/controllers/export_controller.dart';

class AutoSave {
  bool enabled;
  int interval;
  bool export;
  ExportAs exportAs;

  AutoSave({
    this.enabled = true,
    this.interval = 60,
    this.export = true,
    this.exportAs = ExportAs.getx,
  });

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'interval': interval,
      'export': export,
      'exportAs': exportAs.toString(),
    };
  }

  factory AutoSave.fromMap(Map<String, dynamic> map) {
    return AutoSave(
      enabled: map['enabled'],
      interval: map['interval'],
      export: map['export'],
      exportAs: map['exportAs'] == null
          ? ExportAs.getx
          : ExportAs.values
              .firstWhere((element) => map['exportAs'] == element.toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoSave.fromJson(String source) =>
      AutoSave.fromMap(json.decode(source));
}
