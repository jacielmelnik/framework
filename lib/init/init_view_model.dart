import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:framework/firebase_options.dart';
import 'package:framework/login/login_view.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:framework/constants.dart';

class InitViewModel {
  static Future<void> initializeApp(BuildContext context) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    await AppLocalizations.load();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: Constants.loginRouteName),
        builder: (_) => LoginView(),
      ),
    );
  }
}
