// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'dart:developer';
import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    void didChangeAppLifecycleState(AppLifecycleState state) {
      super.didChangeAppLifecycleState(state);

      if (state == AppLifecycleState.resumed) {
        // User online
      } else if (state == AppLifecycleState.paused) {
        // User Offline
      } else {
        // User Offline
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int argId = Get.arguments;
  late int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Friend",
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
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'exit') {
                Get.offNamed("/");
              }
              if (value == 'sign out') {
                Get.offNamed("/");
              }
              if (value == 'Crate New') {
                Get.offNamed("/SignInPage");
              }
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  value: 'sign out',
                  child: Text("Sign Out"),
                ),
                PopupMenuItem(
                  value: 'Crate New',
                  child: Text("Create Account"),
                ),
                PopupMenuItem(
                  value: 'exit',
                  child: Text("Exit"),
                ),
              ];
            },
          )
        ],
        backgroundColor: Colors.grey.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: FireStoreHelper.fireStoreHelper.getAllUser(id: argId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?['contacts']?.length,
                itemBuilder: (context, index) {
                  // Get User
                  Map<String, dynamic>? allUser = snapshot.data;
                  Map data = {
                    'sender': allUser?['contacts'][index],
                    'recieved': allUser,
                  };

                  Stream name = FireStoreHelper.fireStoreHelper
                      .userStream(recievedId: argId);

                  if (snapshot.data?['contacts'].length > 0) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1.6, 1.1),
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(
                            "/ChatPage",
                            arguments: data,
                          );
                        },
                        // title: Text("${name}"),
                        title: Text(
                          "${allUser?['contacts'][index]}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            shadows: [
                              BoxShadow(
                                offset: Offset(1.4, 0.9),
                                color: Colors.black26,
                              ),
                            ],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.navigate_next_outlined,
                            color: Colors.black,
                            shadows: [
                              BoxShadow(
                                offset: Offset(1.4, 0.9),
                                color: Colors.black26,
                              ),
                            ],
                            size: 40,
                          ),
                          onPressed: () {
                            Get.toNamed(
                              "/ChatPage",
                              arguments: data,
                            );
                            FireStoreHelper.fireStoreHelper.removeContact(
                              userId: argId,
                              removedContactId:
                                  allUser!['contacts'][index].toString(),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return null;
                },
              );
            } else if (snapshot.hasError) {
              log("Error: ${snapshot.error}");
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/AddContacts",arguments: argId);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Colors.blueGrey.shade50,
    );
  }
}
