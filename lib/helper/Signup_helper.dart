import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class SignupHelper {
  SignupHelper._();

  static final SignupHelper signupHelper = SignupHelper._();

  registeredSignUp({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      log("{[ $emailAddress ]}");
      log("{[ $password ]}");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.!!');
        return false;
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.!!');
        return false;
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        log('Invalid Login Info.!!');
      }
      log('= Error Are Finding.!! = $e');
      return false;
    } catch (e) {
      log("$e");
      return false;
    }
  }
}
