import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:framework/constants.dart';
import 'package:framework/store/store_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel {
  static final TextEditingController _emailTextController =
      TextEditingController(text: '');
  static final TextEditingController _passwordTextController =
      TextEditingController(text: '');

  static Future<void> login(BuildContext context) async {
    try {
      final UserCredential _credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text.toLowerCase().trim(),
        password: _passwordTextController.text,
      );

      print('Firebase credential used to log in: $_credential');

      LoginViewModel.storeFirebaseToken(_credential);

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const StoreView();
        },
      ));

      //Clearing data after succesfully logging in
      LoginViewModel._clearEmailAndPassword();

      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static register(BuildContext context) async {
    try {
      final UserCredential _credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text.toLowerCase().trim(),
        password: _passwordTextController.text,
      );

      print('Firebase credential created: $_credential');

      LoginViewModel.storeFirebaseToken(_credential);

      LoginViewModel.login(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static _clearEmailAndPassword() {
    _emailTextController.text = "";
    _passwordTextController.text = "";
  }

  static emailTextController() {
    return _emailTextController;
  }

  static passwordTextController() {
    return _passwordTextController;
  }

  static storeFirebaseToken(UserCredential credential) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Constants.kFirebaseTokenKey, credential.user!.uid);
  }

  static Future<String?> getStoredFirebaseToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Constants.kFirebaseTokenKey);
  }
}
