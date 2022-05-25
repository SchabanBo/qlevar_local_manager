import 'dart:convert';

class TranslationSettings {
  String googleApi;

  TranslationSettings({
    this.googleApi = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'googleApi': googleApi,
    };
  }

  factory TranslationSettings.fromMap(Map<String, dynamic> map) {
    return TranslationSettings(
      googleApi: map['googleApi'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslationSettings.fromJson(String source) =>
      TranslationSettings.fromMap(json.decode(source));
}
