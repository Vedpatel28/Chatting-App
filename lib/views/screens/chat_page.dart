import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    List userData = Get.arguments;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            StreamBuilder(
              stream: FireStoreHelper.fireStoreHelper.userStream(
                sentId: userData[0],
                recievedId: userData[0],
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${userData[0]}");
                } else {
                  return Center(
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
