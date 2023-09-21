import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  int userId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.userStream(
            recievedId: userId,
          ),
          builder: (context, snapshot) {
            DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
            log("Id: $data \n Id: $userId");
            if (snapshot.hasData) {
              return Text("${data?['name']}");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StreamBuilder(
              stream: FireStoreHelper.fireStoreHelper.userStream(
                recievedId: userId,
              ),
              builder: (context, snapshot) {
                DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;

                if (snapshot.hasData) {
                  return Text("${data?['sent']['102']}");
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
