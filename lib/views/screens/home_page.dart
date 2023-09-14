import 'dart:developer';

import 'package:chat_app_firebase/helper/Signup_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount account = Get.arguments;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Image.network(
                "${account.photoUrl}",
              ),
              accountName: Text("${account.displayName}"),
              accountEmail: Column(
                children: [
                  Text(account.email),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                bool logout = SignupHelper.signupHelper.logoutUser();
                log("$logout");
                (logout == true)
                    ? Get.offNamed("/")
                    : Get.snackbar(
                  "Something Wrong",
                  "Your Logout Failed",
                );
              },
              icon: const Icon(
                Icons.logout_outlined,
              ),
              label: Text(
                "Log-out",
                style: GoogleFonts.headlandOne(),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Home"),
      ),
    );
  }
}
