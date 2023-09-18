// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String id = "";
  String name = "";
  String password = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(20),
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
                  log("Id = $id");
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("ID"),
                ),
              ),
              const Gap(20),
              TextFormField(
                initialValue: name,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter User Name";
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  name = newValue!;
                  log("Name = $name");
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("User Name"),
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
                  log("Password = $password");
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                ),
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    FireStoreHelper.fireStoreHelper.getCredential(
                      id: int.parse(id),
                    );
                    log("SussesFull Added");
                    Get.offNamed("/HomePage");
                  }
                },
                child: const Text(
                  "SUBMIT",
                ),
              ),
            ],
          ),
        ),
      ),
      // SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(16),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             SizedBox(height: s.height * 0.02),
      //             Text(
      //               "Sign in",
      //               style: GoogleFonts.headlandOne(
      //                 color: const Color(0xFF27447C),
      //                 fontSize: 30,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             SizedBox(height: s.height * 0.14),
      //             // E-Mail
      //             TextField(
      //               onSubmitted: (value) {
      //                 email = value;
      //               },
      //               decoration: InputDecoration(
      //                 filled: true,
      //                 fillColor: Colors.blueGrey.shade50,
      //                 hintText: "Enter E-mail",
      //                 border: const OutlineInputBorder(
      //                   borderRadius: BorderRadius.all(
      //                     Radius.circular(15),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: s.height * 0.04),
      //             // Password
      //             TextField(
      //               onSubmitted: (value) {
      //                 password = value;
      //               },
      //               decoration: InputDecoration(
      //                 filled: true,
      //                 fillColor: Colors.blueGrey.shade50,
      //                 hintText: "Enter Password",
      //                 border: const OutlineInputBorder(
      //                   borderRadius: BorderRadius.all(
      //                     Radius.circular(15),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: s.height * 0.06),
      //             GestureDetector(
      //               onTap: () async {
      //                 bool login = await SignupHelper.signupHelper
      //                     .loginWitheEmailPassword(
      //                   email: email,
      //                   password: password,
      //                   name: name,
      //                 );
      //
      //                 login
      //                     ? Get.offNamed("/HomePage")
      //                     : Get.snackbar(
      //                         "Re-Try",
      //                         "Something Wrong ⚠️",
      //                         overlayColor: Colors.red,
      //                         borderColor: Colors.redAccent.shade100,
      //                       );
      //               },
      //               child: Container(
      //                 height: s.height * 0.065,
      //                 width: s.width * 0.5,
      //                 decoration: const BoxDecoration(
      //                   color: Color(0xFF27447C),
      //                   borderRadius: BorderRadius.all(
      //                     Radius.circular(20),
      //                   ),
      //                 ),
      //                 alignment: Alignment.center,
      //                 child: Text(
      //                   "Sign-in",
      //                   style: GoogleFonts.headlandOne(
      //                     fontSize: 22,
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: s.height * 0.03),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 GestureDetector(
      //                   onTap: () async {
      //                     GoogleSignInAccount? account = await SignupHelper
      //                         .signupHelper
      //                         .loginWitheGoogle();
      //
      //                     UserModal userModal = UserModal(
      //                       userImage: account?.photoUrl,
      //                       userName: account?.displayName,
      //                       userEmail: account?.email,
      //                     );
      //
      //                     // userModal.userName;
      //                     // userModal.userEmail;
      //                     // userModal.userImage;
      //
      //                     (account != null)
      //                         ? Get.offNamed(
      //                             "/HomePage",
      //                             arguments: userModal,
      //                           )
      //                         : Get.snackbar(
      //                             "Re-Try",
      //                             "Something Wrong ⚠️",
      //                             overlayColor: Colors.red,
      //                             borderColor: Colors.redAccent.shade100,
      //                           );
      //                   },
      //                   child: Column(
      //                     children: [
      //                       CircleAvatar(
      //                         radius: 20,
      //                         backgroundImage:
      //                             AssetImage("$imagePath/Google.png"),
      //                       ),
      //                       SizedBox(height: s.height * 0.01),
      //                       Text(
      //                         "Google",
      //                         style: GoogleFonts.headlandOne(
      //                           fontSize: 12,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(width: s.width * 0.1),
      //                 GestureDetector(
      //                   onTap: () {
      //                     bool login = SignupHelper.signupHelper.gesteAccount();
      //                     login
      //                         ? Get.offNamed("/HomePage")
      //                         : Get.snackbar(
      //                             "Re-Try",
      //                             "Something Wrong ⚠️",
      //                             overlayColor: Colors.red,
      //                             borderColor: Colors.redAccent.shade100,
      //                           );
      //                   },
      //                   child: Column(
      //                     children: [
      //                       const CircleAvatar(
      //                         radius: 20,
      //                         backgroundColor: Colors.white,
      //                         child: Icon(
      //                           Icons.no_accounts,
      //                           color: Colors.black,
      //                           size: 25,
      //                         ),
      //                       ),
      //                       SizedBox(height: s.height * 0.01),
      //                       Text(
      //                         "Geste",
      //                         style: GoogleFonts.headlandOne(
      //                           fontSize: 12,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //       Transform.translate(
      //         offset: const Offset(0, 100),
      //         child: Image.asset("$imagePath/travel.png"),
      //       ),
      //     ],
      //   ),
      // ),
      backgroundColor: const Color(0xFFDDE2E5),
    );
  }
}
