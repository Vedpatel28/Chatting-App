// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:chat_app_firebase/controller/first_time_login_controller.dart';
import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String id = "";
  String password = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FirstTimeCheck firstTimeCheck = Get.put(FirstTimeCheck());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(40),
                Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Images/login.gif"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Gap(50),
                TextFormField(
                  initialValue: id,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter User ID";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    id = newValue!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("ID"),
                  ),
                ),
                const Gap(20),
                TextFormField(
                  initialValue: password,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    password = newValue!;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                  ),
                ),
                const Gap(20),
                TextButton(
                  onPressed: () {
                    Get.offNamed("/SignInPage");
                  },
                  child: const Text(
                    "crate new user",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      FireStoreHelper.fireStoreHelper.validateUser(
                        id: int.parse(id),
                        password: password,
                      );
                      firstTimeCheck.setOne();
                      FireStoreHelper.fireStoreHelper.getCredential(
                        id: int.parse(id),
                      );

                      Map<String, dynamic>? data =
                          await FireStoreHelper.fireStoreHelper.getAllUser(
                        id: int.parse(id),
                      );

                      String checkPassword = data?['password'];
                      int checkID = data?['id'];
                      log(checkPassword);
                      if (password == checkPassword && int.parse(id) == checkID) {
                        Get.offNamed(
                          "/HomePage",
                          arguments: int.parse(id),
                        );
                      } else {
                        Get.snackbar(
                          "Password or Id",
                          "Id or Password Wrong!!",
                        );
                      }
                    }
                  },
                  child: const Text("SUBMIT"),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
