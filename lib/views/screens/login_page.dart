import 'package:chat_app_firebase/helper/authentication_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          16,
        ),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  bool login = await AuthenticationHelper.authenticationHelper
                      .loginAnonymously();

                  if (login) {
                    Get.offNamed("/HomePage");
                  }
                },
                child: const Text("Guest Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
