// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
            color: const Color(0xFFEEEEEE),
          ),
        ),
        backgroundColor: const Color(0xFF26577C),
        // Receiver Name
        title: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.userStream(
            recievedId: userId['sender'],
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Receiver Name
              return Text(
                "${userId['sender']}",
                style: GoogleFonts.bubblegumSans(
                  fontSize: 22,
                  color: const Color(0xFFEEEEEE),
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
            // All Chat Part
            Expanded(
              child: StreamBuilder(
                stream: FireStoreHelper.fireStoreHelper.userStream(
                  recievedId: userId['sender'],
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // All Fire Base Data Facing
                    Map<String, dynamic>? data =
                        snapshot.data as Map<String, dynamic>?;

                    // All Sent Chat
                    List<dynamic>? sentChat =
                        data!['sent']['${userId['recieved']['id']}']['msg'];

                    // All Received Chat
                    List<dynamic>? recievedChat =
                        data['recieved']['${userId['recieved']['id']}']['msg'];

                    // All Sent Time
                    List<dynamic>? sentTime =
                        data['sent']['${userId['recieved']['id']}']['time'];

                    // All Received Time
                    List<dynamic>? recievedTime =
                        data['recieved']['${userId['recieved']['id']}']['time'];

                    List sTime = sentTime!.map(
                      (e) {
                        List<String> strData = e.split('-');

                        var date = strData[0].split('/');
                        var time = strData[1].split(':');

                        DateTime dt = DateTime(
                          int.parse(date[2]),
                          int.parse(date[1]),
                          int.parse(date[0]),
                          int.parse(time[0]),
                          int.parse(time[1]),
                        );

                        String sentFormattedTime = DateFormat.jm().format(dt);
                        return sentFormattedTime;
                      },
                    ).toList();

                    List rTime = recievedTime!.map(
                      (e) {
                        List<String> strData = e.split('-');

                        var date = strData[0].split('/');
                        var time = strData[1].split(':');

                        DateTime dt = DateTime(
                          int.parse(date[2]),
                          int.parse(date[1]),
                          int.parse(date[0]),
                          int.parse(time[0]),
                          int.parse(time[1]),
                        );
                        String recievedFormattedTime =
                            DateFormat.jm().format(dt);

                        return recievedFormattedTime;
                      },
                    ).toList();

                    return ListView.builder(
                      // Check Length
                      itemCount: (sentChat!.length < recievedChat!.length)
                          ? sentChat.length
                          : recievedChat.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            // Sent Chat
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onDoubleTap: () {
                                    int chatIndex = sentChat
                                        .indexOf(sentChat[index]);
                                    log("${chatIndex}");
                                    FireStoreHelper.fireStoreHelper
                                        .deleteChat(
                                      sentId: userId['sender'],
                                      receicerId: userId['recieved']['id'],
                                      chatIndex: chatIndex,
                                    );
                                  },
                                  onLongPress: () {
                                    showDialog(context: context, builder: (context) {
                                      return const AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                label: Text("Message"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 5,
                                      top: 5,
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.elliptical(15, 12),
                                        topLeft: Radius.elliptical(20, 12),
                                        bottomLeft: Radius.elliptical(20, 12),
                                      ),
                                      color: Color(0xFF26577C),
                                    ),
                                    margin: const EdgeInsets.all(6),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        // Decoration Sent Chat Box
                                        Container(
                                          width: s.width * 0.8,
                                          alignment: Alignment.topRight,
                                          // Sent Chat
                                          child: Text(
                                            "${sentChat[index]}",
                                            style: GoogleFonts.changa(
                                              fontSize: 22,
                                              color: const Color(0xFFF0F0F0),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: const Offset(140, 0),
                                          child: Text(
                                            "${sTime[index]}",
                                            style: GoogleFonts.changa(
                                              fontSize: 10,
                                              color: const Color(0xFFF5F5F5),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Received Chat
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 5,
                                    top: 5,
                                  ),
                                  margin: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.elliptical(15, 12),
                                      topRight: Radius.elliptical(20, 12),
                                      bottomLeft: Radius.elliptical(20, 12),
                                    ),
                                    color: Color(0xFF141E46),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      // Decoration Received Chat Box
                                      Container(
                                        width: s.width * 0.8,
                                        alignment: Alignment.topLeft,
                                        // Received Chat Box
                                        child: Text(
                                          "${recievedChat[index]}",
                                          style: GoogleFonts.changa(
                                            color: const Color(0xFFFAFAFA),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(-135, 0),
                                        child: Text(
                                          "${rTime[index]}",
                                          style: GoogleFonts.changa(
                                            fontSize: 10,
                                            color: Colors.white,
                                            // color: const Color(0xFFFFFADD),
                                            fontWeight: FontWeight.bold,
                                          ),
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
                    FireStoreHelper.fireStoreHelper.sentNewMassage(
                      sentId: userId['sender'],
                      receiverId: userId['recieved']['id'],
                      msg: sendMassage.text,
                    );
                    sendMassage.clear();
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
