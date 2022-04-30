import 'package:framework/constants.dart';

class LanguageViewModel {
  static changeToLanguage(AvailableLanguages language) {
    print('Will translate to ${language.value}');
  }
}
