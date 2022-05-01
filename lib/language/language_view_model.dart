import 'package:flutter/material.dart';
import 'package:framework/constants.dart';
import 'package:framework/shared/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageViewModel {
  static changeToLanguage(
      BuildContext context, AvailableLanguages language) async {
    print('Will translate to ${language.value}');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Constants.kLanguageCodeKey, language.value);

    //Definitelly not the best usability
    //
    //The App views should depend on InheritedWidget to rebuild itself properly
    //when the user changes the language
    RestartAppWidget.restartApp(context);
  }
}
