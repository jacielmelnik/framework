import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:framework/constants.dart';
import 'package:framework/language/language_view.dart';

class SettingsViewModel {
  static logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(
      context,
      ModalRoute.withName(Constants.loginRouteName),
    );
  }

  static changeLanguage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LanguageView()));
  }
}
