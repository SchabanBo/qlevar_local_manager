import 'dart:convert';

class TranlationSettings {
  String googleApi;

  TranlationSettings({
    this.googleApi = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'googleApi': googleApi,
    };
  }

  factory TranlationSettings.fromMap(Map<String, dynamic> map) {
    return TranlationSettings(
      googleApi: map['googleApi'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TranlationSettings.fromJson(String source) =>
      TranlationSettings.fromMap(json.decode(source));
}
