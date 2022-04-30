import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:framework/store/store_view.dart';

class LoginViewModel {
  static final TextEditingController _emailTextController =
      TextEditingController(text: 'firebase@test.com');
  static final TextEditingController _passwordTextController =
      TextEditingController(text: 'weakPASS123');

  static login(BuildContext context) async {
    try {
      final UserCredential _credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text.toLowerCase().trim(),
        password: _passwordTextController.text,
      );

      print('Firebase credential used to log in: $_credential');

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const StoreView();
        },
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static register() async {
    try {
      final UserCredential _credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text.toLowerCase().trim(),
        password: _passwordTextController.text,
      );

      print('Firebase credential created: $_credential');
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

  static emailTextController() {
    return _emailTextController;
  }

  static passwordTextController() {
    return _passwordTextController;
  }
}
