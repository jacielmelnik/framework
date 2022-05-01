import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:framework/constants.dart';
import 'package:framework/shared/user_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalizations extends ChangeNotifier {
  AppLocalizations._privateConstructor();

  static final AppLocalizations instance =
      AppLocalizations._privateConstructor();

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static Map<String, String>? _localizedStrings;

  static Future<bool> load({bool cache = false}) async {
    String languageCode = await UserStorage.getLanguageCode() ??
        Platform.localeName.split('_').first;

    // Load the language JSON file from the "lang" folder
    String jsonString =
        await rootBundle.loadString('i18n/$languageCode.json', cache: cache);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  static String translate(String key) {
    if (_localizedStrings == null) {
      AppLocalizations.load();
    }
    if (_localizedStrings![key] == null) {
      return key;
    }
    return _localizedStrings![key]!;
  }

  static String revertTranslation({String value = ''}) {
    if (_localizedStrings == null) {
      AppLocalizations.load();
    }
    return _localizedStrings!.keys
        .firstWhere((v) => _localizedStrings![v] == value, orElse: () => '');
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    await AppLocalizations.load();
    return AppLocalizations.instance;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
