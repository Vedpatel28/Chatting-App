import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  Map userId = Get.arguments;

  TextEditingController sendMassage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0D1282),
        title: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.userStream(
            recievedId: userId['sender'],
          ),
          builder: (context, snapshot) {
            Map<String, dynamic>? data = snapshot.data as Map<String, dynamic>?;
            if (snapshot.hasData) {
              return Text(
                "${data?['name']}",
                style: GoogleFonts.bubblegumSans(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
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
            Expanded(
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
                    List<dynamic>? recievedChat =
                        data['recieved']['101']['msg'];
                    List<dynamic>? recievedTime =
                        data['recieved']['101']['time'];

                    log("Sent : $sentChat");

                    return ListView.builder(
                      itemCount: sentChat?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0D1282),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.elliptical(10, 10),
                                      topRight: Radius.elliptical(10, 10),
                                      bottomLeft: Radius.elliptical(10, 10),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${sentChat?[index]}",
                                    style: GoogleFonts.bubblegumSans(
                                      fontSize: 22,
                                      color: const Color(0xFFF0DE36),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0D1282),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.elliptical(10, 10),
                                      topRight: Radius.elliptical(10, 10),
                                      bottomLeft: Radius.elliptical(10, 10),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        "${recievedChat?[index]}",
                                        style: GoogleFonts.changa(
                                          fontSize: 22,
                                          color: const Color(0xFFF0DE36),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
            TextField(
              controller: sendMassage,

              textInputAction: TextInputAction.newline,
              cursorHeight: 30,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF0D1282).withOpacity(0.2),
                hintText: "Message",
                suffixIcon: IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
