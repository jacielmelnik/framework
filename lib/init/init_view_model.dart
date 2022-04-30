import 'package:flutter/material.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:framework/store/store_view.dart';

class InitViewModel {
  static Future<void> initializeApp(BuildContext context) async {
    await AppLocalizations.load();

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const StoreView();
      },
    ));
  }
}
