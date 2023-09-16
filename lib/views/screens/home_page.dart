// ignore_for_file: unnecessary_null_comparison

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:chat_app_firebase/modal/fire_store_modal.dart';
import 'package:chat_app_firebase/modal/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  String? name;
  int? age;
  int? id;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    UserModal? userModal = Get.arguments;

    return Scaffold(
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       UserAccountsDrawerHeader(
      //         currentAccountPicture: Visibility(
      //           visible: userModal != null,
      //           child: CircleAvatar(
      //             foregroundImage: NetworkImage("${userModal?.userImage}"),
      //           ),
      //         ),
      //         accountName: Visibility(
      //           visible: userModal != null,
      //           child: Text(
      //             userModal?.userName ?? "Geste Account",
      //             style: GoogleFonts.headlandOne(),
      //           ),
      //         ),
      //         accountEmail: Visibility(
      //           visible: userModal != null,
      //           child: Text(
      //             userModal?.userEmail ?? "Geste Account",
      //             style: GoogleFonts.headlandOne(),
      //           ),
      //         ),
      //       ),
      //       ElevatedButton.icon(
      //         onPressed: () async {
      //           bool logout = await SignupHelper.signupHelper.logoutUser();
      //           log("$logout");
      //           (logout == true)
      //               ? Get.offNamed("/")
      //               : Get.snackbar(
      //                   "Something Wrong",
      //                   "Your Logout Failed",
      //                 );
      //         },
      //         icon: const Icon(
      //           Icons.logout_outlined,
      //         ),
      //         label: Text(
      //           "Log-out",
      //           style: GoogleFonts.headlandOne(),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onSubmitted: (value) {
                        name = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Name",
                      ),
                    ),
                    SizedBox(height: s.height * 0.02),
                    TextField(
                      onSubmitted: (value) {
                        age = int.parse(value);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Age",
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton.icon(
                    onPressed: () {
                      FireStoreHelper.fireStoreHelper.addStudent(
                        fireStoreModal: FireStoreModal(
                          id!,
                          name!,
                          age!,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    label: const Text("Continue"),
                    icon: const Icon(
                      Icons.keyboard_double_arrow_right,
                    ),
                  )
                ],
              ),
            );
          },
          icon: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
