import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:chat_app_firebase/modal/fire_store_modal.dart';
import 'package:chat_app_firebase/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  late int id;
  late String name;
  late String password;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                  // Id
                  TextField(
                    onSubmitted: (value) {
                      id = int.parse(value);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade50,
                      hintText: "Enter Id",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: s.height * 0.04),
                  // E-Mail
                  TextField(
                    onSubmitted: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade50,
                      hintText: "Enter Name",
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
                      FireStoreModal fireStoreModal = FireStoreModal(
                        id,
                        name,
                        password,
                        // received,
                        // sent,
                        // contacts,
                      );
                      FireStoreHelper.fireStoreHelper
                          .addUser(fireStoreModal: fireStoreModal);
                      Get.offNamed("/HomePage");
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
                        "Crate",
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
                        onTap: () async {},
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  const Color(0xFF8A99B5).withOpacity(0.6),
                              child: const Icon(
                                Icons.g_mobiledata_outlined,
                                size: 40,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: s.height * 0.01),
                            Text(
                              "Google",
                              style: GoogleFonts.headlandOne(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF8A99B5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: s.width * 0.1),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  const Color(0xFF8A99B5).withOpacity(0.6),
                              child: const Icon(
                                Icons.no_accounts,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: s.height * 0.01),
                            Text(
                              "Geste",
                              style: GoogleFonts.headlandOne(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF8A99B5),
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
              offset: const Offset(0, 100),
              child: Image.asset("$imagePath/travel.png"),
            ),
          ],
        ),
      ),
    );
  }
}
