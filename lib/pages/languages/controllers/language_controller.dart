import 'package:get/get.dart';

import '../../main/controllers/main_controller.dart';

class LanguageController extends GetxController {
  final main = Get.find<MainController>();

  List<String> get languages => main.locals().languages;

  void addLanguage(String language) {
    languages.add(language);
    main.locals().ensureAllLanguagesExist(main.locals().languages);
    main.locals.refresh();
  }

  void removeLanguage(String language) {
    main.locals().languages.remove(language);
    main.locals().removeLanguage(language);
    main.locals.refresh();
  }

  void updateLanguage(String oldLanguage, String newLanguage) {
    main.locals().languages.remove(oldLanguage);
    main.locals().languages.add(newLanguage);
    main.locals().updateLanguage(oldLanguage, newLanguage);
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
  void onClose() {
    main.locals.refresh();
    main.saveData();
    super.onClose();
  }
}
