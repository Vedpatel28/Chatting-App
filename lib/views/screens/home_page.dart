// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'dart:developer';
import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  int argId = Get.arguments;

  late String name;
  late int age;
  late int id;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: FireStoreHelper.fireStoreHelper.getAllUser(id: argId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?['contacts'].length,
                itemBuilder: (context, index) {
                  Map<String,dynamic>? allUser = snapshot.data;
                  log("Home User : ${snapshot.data}");
                  Map data = {
                    'sender': allUser?['contacts'][index],
                    'recieved': allUser,
                  };
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
      ),
    );
  }
}
