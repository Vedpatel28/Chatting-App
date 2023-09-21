import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:chat_app_firebase/modal/get_user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  List<GetUserModal> userData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.userStream(
            recievedId: userData[0].id,
          ),
          builder: (context, snapshot) {
            DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
            log("Data: $data \n Id: ${userData[0].name}");
            if (snapshot.hasData) {
              return Text("${data?['sent']}");
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
                recievedId: userData[0].id,
              ),
              builder: (context, snapshot) {
                DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;

                if (snapshot.hasData) {
                  return Text("${data?['sent']}");
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
