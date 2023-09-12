import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginHelper {
  GoogleLoginHelper._();

  static final GoogleLoginHelper googleLoginHelper = GoogleLoginHelper._();

  loginUser() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signIn();
    } catch (e) {
      log("$e");
    }
  }
}
