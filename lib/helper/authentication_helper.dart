import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  AuthenticationHelper._();

  static final AuthenticationHelper authenticationHelper =
      AuthenticationHelper._();

  loginAnonymously() async {
    try {
      FirebaseAuth.instance.signInAnonymously();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "operation-not-allowed") {
        log(e.code);
      }
    }
    return false;
  }

  logoutUser() async {
    await FirebaseAuth.instance.signOut();
    return true;
  }
}
