import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  Map userId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.userStream(
            recievedId: userId['sender'],
          ),
          builder: (context, snapshot) {
            Map<String, dynamic>? data = snapshot.data as Map<String, dynamic>?;
            // List sentChat = data?['sent']['${userId['id']['recieved']}']['msg'];
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
        child: Container(
          height: s.height * 0.8,
          child: StreamBuilder(
            stream: FireStoreHelper.fireStoreHelper.userStream(
              recievedId: userId['sender'],
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic>? data =
                    snapshot.data as Map<String, dynamic>?;
                log("senders Id : ${userId['sender']}");
                List<dynamic>? sentChat = data!['sent']['101']['msg'];
                List<dynamic>? recievedChat = data['recieved']['101']['msg'];
                log("Sent : $sentChat");

                return ListView.builder(
                  itemCount: sentChat?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              child: Text("${sentChat?[index]}"),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${recievedChat?[index]}"),
                          ],
                        ),
                      ],
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
