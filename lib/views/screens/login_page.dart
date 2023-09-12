import 'package:chat_app_firebase/helper/Signup_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // E-Mail
            TextField(
              onSubmitted: (value) {
                email = value;
              },
              decoration: const InputDecoration(
                hintText: "Enter E-mail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: s.height * 0.02),
            // Password
            TextField(
              onSubmitted: (value) {
                password = value;
              },
              decoration: const InputDecoration(
                hintText: "Enter Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: s.height * 0.02),
            ElevatedButton(
              onPressed: () async {
                await SignupHelper.signupHelper.registeredSignUp(
                  emailAddress: email!,
                  password: password!,
                );
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
