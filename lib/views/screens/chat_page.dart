import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:chat_app_firebase/modal/get_user_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<GetUserModal> userData = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.userStream(
            recievedId: userData[0].id,
          ),
          builder: (context, snapshot) {
             Map data = snapshot.data as Map;
             log("Data: $data \n Id: ${userData[0].name}");

            if (snapshot.hasData) {
              return Text("${data['sent']}");
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
                if (snapshot.hasData) {
                  return Text("${userData[0].id}");
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
