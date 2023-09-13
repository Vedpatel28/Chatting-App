// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:chat_app_firebase/helper/Signup_helper.dart';
import 'package:chat_app_firebase/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    GoogleSignInAccount? account = Get.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: s.height * 0.02),
                  Text(
                    "Sign in",
                    style: GoogleFonts.headlandOne(
                      color: const Color(0xFF27447C),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: s.height * 0.14),
                  // E-Mail
                  TextField(
                    onSubmitted: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade50,
                      hintText: "Enter E-mail",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: s.height * 0.04),
                  // Password
                  TextField(
                    onSubmitted: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade50,
                      hintText: "Enter Password",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: s.height * 0.06),
                  GestureDetector(
                    onTap: () async {
                      bool login = await SignupHelper.signupHelper
                          .loginWitheEmailPassword(
                        email: email,
                        password: password,
                      );

                      login
                          ? Get.offNamed("/HomePage")
                          : Get.snackbar(
                              "Re-Try",
                              "Something Wrong ⚠️",
                              overlayColor: Colors.red,
                              borderColor: Colors.redAccent.shade100,
                            );
                    },
                    child: Container(
                      height: s.height * 0.065,
                      width: s.width * 0.5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF27447C),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Sign-in",
                        style: GoogleFonts.headlandOne(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: s.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await SignupHelper.signupHelper.loginWitheGoogle();

                          log("Completed Google Login");

                          // (account != null)
                          //     ? Get.offNamed("/HomePage", arguments: account)
                          //     : Get.snackbar(
                          //         "Re-Try",
                          //         "Something Wrong ⚠️",
                          //         overlayColor: Colors.red,
                          //         borderColor: Colors.redAccent.shade100,
                          //       );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage("$imagePath/Google.png"),
                            ),
                            SizedBox(height: s.height * 0.01),
                            Text(
                              "Google",
                              style: GoogleFonts.headlandOne(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: s.width * 0.1),
                      GestureDetector(
                        onTap: () {
                          bool login = SignupHelper.signupHelper.gesteAccount();
                          login
                              ? Get.offNamed("/HomePage")
                              : Get.snackbar(
                                  "Re-Try",
                                  "Something Wrong ⚠️",
                                  overlayColor: Colors.red,
                                  borderColor: Colors.redAccent.shade100,
                                );
                        },
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.no_accounts,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                            SizedBox(height: s.height * 0.01),
                            Text(
                              "Geste",
                              style: GoogleFonts.headlandOne(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Transform.translate(
                offset: const Offset(0, 500),
                child: Image.asset("$imagePath/travel.png")),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFDDE2E5),
    );
  }
}
