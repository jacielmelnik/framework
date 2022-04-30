import 'package:flutter/material.dart';
import 'package:framework/login/login_view.dart';
import 'package:framework/shared/app_localizations.dart';

class InitViewModel {
  static Future<void> initializeApp(BuildContext context) async {
    await AppLocalizations.load();

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const LoginView();
      },
    ));
  }
}
