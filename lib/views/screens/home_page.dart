// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'package:chat_app_firebase/helper/Signup_helper.dart';
import 'package:chat_app_firebase/modal/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModal? userModal = Get.arguments;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Visibility(
                visible: userModal != null,
                child: CircleAvatar(
                  foregroundImage: NetworkImage("${userModal?.userImage}"),
                ),
              ),
              accountName: Visibility(
                visible: userModal != null,
                child: Text(
                  userModal?.userName ?? "Geste Account",
                  style: GoogleFonts.headlandOne(),
                ),
              ),
              accountEmail: Visibility(
                visible: userModal != null,
                child: Text(
                  userModal?.userEmail ?? "Geste Account",
                  style: GoogleFonts.headlandOne(),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                bool logout = await SignupHelper.signupHelper.logoutUser();
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
