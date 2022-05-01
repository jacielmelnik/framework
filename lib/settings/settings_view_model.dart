import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:framework/constants.dart';
import 'package:framework/language/language_view.dart';
import 'package:framework/shared/user_storage.dart';

class SettingsViewModel {
  static logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(
      context,
      ModalRoute.withName(Constants.loginRouteName),
    );
  }

  static changeLanguage(BuildContext context) async {
    final String currentLanguage = await UserStorage.getLanguageCode() ??
        Platform.localeName.split('_').first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LanguageView(currentLanguage: currentLanguage),
      ),
    );
  }
}
