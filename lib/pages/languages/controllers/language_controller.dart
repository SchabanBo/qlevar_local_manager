import 'dart:async';

import '../../../services/di_service.dart';
import '../../main/controllers/main_controller.dart';

class LanguageController extends Controller {
  final main = getService<MainController>();

  List<String> get languages => main.locals.value.languages;

  void addLanguage(String language) {
    languages.add(language);
    main.locals.value.ensureAllLanguagesExist(main.locals.value.languages);
    main.locals.refresh();
  }

  void removeLanguage(String language) {
    main.locals.value.languages.remove(language);
    main.locals.value.removeLanguage(language);
    main.locals.refresh();
  }

  void updateLanguage(String oldLanguage, String newLanguage) {
    main.locals.value.languages.remove(oldLanguage);
    main.locals.value.languages.add(newLanguage);
    main.locals.value.updateLanguage(oldLanguage, newLanguage);
    main.locals.refresh();
  }

  void moveLanguage(String language, int direction) {
    final index = languages.indexOf(language);
    if (direction == -1) {
      if (index == 0) return;
      languages.removeAt(index);
      languages.insert(index + direction, language);
    } else {
      if (index == languages.length - 1) return;
      languages.removeAt(index);
      languages.insert(index + direction, language);
    }
    main.locals.refresh();
  }

  @override
  FutureOr onDispose() {
    main.locals.refresh();
    main.saveData();
  }
}
