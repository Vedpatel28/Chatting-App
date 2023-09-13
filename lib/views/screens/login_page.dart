import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  late String email;
  late String password;

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
            SizedBox(height: s.height * 0.04),
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
              onPressed: () async {},
              child: const Text("Login"),
            ),
            SizedBox(height: s.height * 0.02),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.g_mobiledata_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
