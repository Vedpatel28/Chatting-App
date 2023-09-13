import 'package:chat_app_firebase/helper/Signup_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? account = Get.arguments;

    Drawer(
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              bool logout = SignupHelper.signupHelper.logoutUser();

              logout
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
          )
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
    );
  }
}
