import 'package:flutter/material.dart';
import 'package:framework/constants.dart';
import 'package:framework/shared/restart_app.dart';
import 'package:framework/shared/user_storage.dart';

class LanguageViewModel {
  static changeToLanguage(
      BuildContext context, AvailableLanguages language) async {
    UserStorage.setLanguageCode(language);

    //Definitelly not the best usability
    //
    //The App views should depend on InheritedWidget to rebuild itself properly
    //when the user changes the language
    RestartAppWidget.restartApp(context);
  }
}
