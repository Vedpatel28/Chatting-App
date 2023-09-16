import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupHelper {
  SignupHelper._();

  static final SignupHelper signupHelper = SignupHelper._();

  loginWitheEmailPassword({
    required String email,
    required String name,
    required String password,
  }) {
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("Done");
      return true;
    } on FirebaseAuthException catch (e) {
      log("=- $e -=");
      return false;
    }
  }

  gesteAccount() {
    try {
      FirebaseAuth.instance.signInAnonymously();
      return true;
    } on FirebaseAuthException catch (e) {
      log("_+ $e +_");
      return false;
    }
  }

  GoogleSignIn google = GoogleSignIn();

  loginWitheGoogle() async {
    GoogleSignInAccount? account = await google.signIn();

    GoogleSignInAuthentication authentication = await account!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential);
    return account;
  }

  Future<bool> logoutUser() async {
    await google.signOut().then(
      (value) {
        log("$value : Log out Successful");
      },
    );
    await FirebaseAuth.instance.signOut();

    return true;
  }
}
