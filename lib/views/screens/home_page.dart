// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'dart:developer';
import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

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
        title: const Text("Contacts"),
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
                  // Get User Name Using Contacts List
                  Future<dynamic> name = FireStoreHelper.fireStoreHelper.getUserNameUsingContact(
                      con: allUser?['contacts'][index]);
                  Map data = {
                    'sender': allUser?['contacts'][index],
                    'recieved': allUser,
                  };
                  if (snapshot.data?['contacts'].length > 0) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.elliptical(60, 60),
                          left: Radius.elliptical(30, 30),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(
                            "/ChatPage",
                            arguments: data,
                          );
                        },
                        title: Text(
                          "$argId",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          "${name}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.navigate_next_outlined,
                            color: Colors.white,
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
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.toNamed(
                          "/ChatPage",
                          arguments: data,
                        );
                      },
                      leading: Text("${allUser?['contacts'][index]}"),
                      trailing: GestureDetector(
                        onTap: () {
                          log(allUser!['contacts'][index].toString());
                          FireStoreHelper.fireStoreHelper.removeContact(
                            userId: argId,
                            removedContactId:
                                allUser['contacts'][index].toString(),
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
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
          FireStoreHelper.fireStoreHelper.addContact(
            userId: argId,
            addContactId: id,
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
