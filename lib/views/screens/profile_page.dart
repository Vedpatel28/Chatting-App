import 'dart:developer';
import 'package:chat_app_firebase/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  int argId = Get.arguments;
  ImagePicker ImagePic = ImagePicker();

  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            shadows: [
              BoxShadow(
                offset: Offset(1.4, 0.9),
                color: Colors.black26,
              ),
            ],
          ),
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.bubblegumSans(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 26,
              shadows: [
                BoxShadow(
                  offset: Offset(1.4, 0.9),
                  color: Colors.black26,
                ),
              ],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              stream:
                  FireStoreHelper.fireStoreHelper.getAllUserStream(id: argId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map allData = snapshot.data;

                  String userName = allData['name'];
                  int userId = allData['id'];
                  String password = allData['password'];

                  TextEditingController textPassword =
                      TextEditingController(text: password);
                  TextEditingController textName =
                      TextEditingController(text: userName);
                  log("userName : $userName  userId : $userId  userPassword : ${textPassword.text} ");
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "$userId",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            shadows: [
                              BoxShadow(
                                offset: Offset(1.4, 0.9),
                                color: Colors.black26,
                              ),
                            ],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Gap(30),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: const Text("Name"),
                        ),
                        controller: textName,
                        onSubmitted: (value) {
                          textName.text = value;
                          FireStoreHelper.fireStoreHelper.updateProfile(
                            id: userId,
                            name: textName.text,
                            password: textPassword.text,
                          );
                        },
                      ),
                      const Gap(20),
                      Obx(
                        () => TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: const Text("Password"),
                            suffixIcon: IconButton(
                              onPressed: () {
                                profileController.changeShow();
                              },
                              icon: const Icon(Icons.remove_red_eye_outlined),
                            ),
                          ),
                          onSubmitted: (value) {
                            textPassword.text = value;
                            FireStoreHelper.fireStoreHelper.updateProfile(
                              id: userId,
                              name: textName.text,
                              password: textPassword.text,
                            );
                          },
                          obscureText: profileController.showPassword.value,
                          controller: textPassword,
                        ),
                      ),
                      const Gap(40),
                      CupertinoButton.filled(
                        onPressed: () {
                          FireStoreHelper.fireStoreHelper.updateProfile(
                            id: userId,
                            name: textName.text,
                            password: textPassword.text,
                          );
                        },
                        child: const Text(
                          "Change",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
