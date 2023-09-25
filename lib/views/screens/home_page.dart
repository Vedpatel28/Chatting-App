// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'dart:developer';
import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/cupertino.dart';
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
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'exit') {
                Get.offNamed("/");
              }
              if (value == 'sign out') {
                Get.offNamed("/");
              }
              if (value == 'delete') {
                Get.offNamed("/");
              }
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  value: 'sign out',
                  child: Text("Sign Out"),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text("Delete Account"),
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
                  Map<String, dynamic>? allUser = snapshot.data;
                  Map data = {
                    'sender': allUser?['contacts'][index],
                    'recieved': allUser,
                  };
                  if (snapshot.data?['contacts'].length > 0) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(
                            "/ChatPage",
                            arguments: data,
                          );
                        },
                        leading: Text("${allUser?['contacts'][index]}"),
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Add contacts"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onSubmitted: (value) {
                      id = int.parse(value);
                      log("ID : $id");
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Id"),
                    ),
                  ),
                ],
              ),
              actions: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                CupertinoButton.filled(
                  padding: const EdgeInsets.all(12),
                  onPressed: () {
                    FireStoreHelper.fireStoreHelper.addContact(
                      userId: argId,
                      addContactId: id,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
// StreamBuilder(
//   stream: FireStoreHelper.fireStoreHelper.getAllUser(id: argId),
//   builder: (context, snapshot) {
//     if (snapshot.hasData) {
//       return ListView.builder(
//         itemCount: snapshot.data?['contacts'].length,
//         itemBuilder: (context, index) {
//           Map<String,dynamic> allUser = snapshot.data;
//           log("Sender Id : ${allUser['contacts'][index]}");
//           Map data = {
//             'sender' : allUser['contacts'][index],
//             'recieved' : allUser,
//           };
//           return Card(
//             child: ListTile(
//               onTap: () {
//                 Get.toNamed(
//                   "/ChatPage",
//                   arguments: data,
//                 );
//               },
//               leading: Text("${allUser['contacts'][index]}"),
//             ),
//           );
//         },
//       );
//     } else if (snapshot.hasError) {
//       log("${snapshot.error}");
//       return Text("${snapshot.error}");
//     } else {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//   },
// ),
