// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:chat_app_firebase/controller/first_time_login_controller.dart';
import 'package:chat_app_firebase/controller/profile_controller.dart';
import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String id = "";
  String password = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {

    Size s = MediaQuery.of(context).size;

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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey.shade50,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    label: Text("ID"),
                  ),
                ),
                const Gap(20),
                Obx(
                  () => TextFormField(
                    initialValue: password,
                    textInputAction: TextInputAction.next,
                    obscureText: profileController.showPassword.value,
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade50,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      label: const Text("Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          profileController.changeShow();
                        },
                        icon: const Icon(Icons.remove_red_eye_outlined),
                      ),
                    ),
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
                GestureDetector(
                  onTap: () async {

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
                      if (password == checkPassword &&
                          int.parse(id) == checkID) {
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
                    } else {
                      Get.snackbar("Failed", "User Can't Axis..");
                    }
                  },
                  child: Container(
                    height: s.height * 0.06,
                    width: s.width * 0.4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF27447C),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Submit",
                      style: GoogleFonts.headlandOne(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
