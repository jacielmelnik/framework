import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared/user_storage.dart';
import 'package:framework/store/store_view.dart';

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

      LoginViewModel.storeFirebaseToken(_credential);

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const StoreView();
        },
      ));

      return;
    } on FirebaseAuthException catch (e) {
      showModalBottomSheetWithErrorMessage(context, e.message.toString());
    } catch (e) {
      showModalBottomSheetWithErrorMessage(context, e.toString());
    }
  }

  static register(BuildContext context) async {
    try {
      final UserCredential _credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text.toLowerCase().trim(),
        password: _passwordTextController.text,
      );

      LoginViewModel.storeFirebaseToken(_credential);

      LoginViewModel.login(context);
    } on FirebaseAuthException catch (e) {
      showModalBottomSheetWithErrorMessage(context, e.message.toString());
    } catch (e) {
      showModalBottomSheetWithErrorMessage(context, e.toString());
    }
  }

  static showModalBottomSheetWithErrorMessage(
      BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          alignment: Alignment.center,
          child: Text(
            'Error:' + message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }

  static clearEmailAndPassword() {
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
    UserStorage.setFirebaseToken(credential.user!.uid);
  }
}
