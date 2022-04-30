import 'package:flutter/material.dart';
import 'package:framework/store/store_view.dart';

class LoginViewModel {
  static final TextEditingController _emailTextController =
      TextEditingController(text: '');
  static final TextEditingController _passwordTextController =
      TextEditingController(text: '');

  static login(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const StoreView();
      },
    ));
  }

  static emailTextController() {
    return _emailTextController;
  }

  static passwordTextController() {
    return _passwordTextController;
  }
}
