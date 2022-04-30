import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsViewModel {
  static logout(BuildContext context) async {
    print('logout pressed');
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, ModalRoute.withName('/LOGIN'));
  }
}
