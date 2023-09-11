import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class LoginHelper {
  LoginHelper._();

  static final LoginHelper loginHelper = LoginHelper._();

  loginUser({required String emailAddress, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.!!');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.🔃');
      }
    } catch (e) {
      log("$e");
    }
  }
}
