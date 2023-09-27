// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:chat_app_firebase/helper/notifications_helper.dart';
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
                                    int chatIndex =
                                        sentChat.indexOf(sentChat[index]);
                                    log("$chatIndex");
                                    FireStoreHelper.fireStoreHelper.deleteChat(
                                      sentId: userId['sender'],
                                      receicerId: userId['recieved']['id'],
                                      chatIndex: chatIndex,
                                    );
                                  },
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: Text("Message"),
                                                ),
                                                onSubmitted: (value) {},
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
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
                                        bottomRight: Radius.circular(25),
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                      ),
                                      // color: Color(0xFFDCF8C6),
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
                                            style: GoogleFonts.bitter(
                                              fontSize: 22,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: const Offset(130, 0),
                                          child: Text(
                                            "${sTime[index]}",
                                            style: GoogleFonts.changa(
                                              fontSize: 12,
                                              color: Colors.black,
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
                                      bottomRight: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25),
                                    ),
                                    // color: Color(0xFFF2F2F0),
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
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(-140, 0),
                                        child: Text(
                                          "${rTime[index]}",
                                          style: GoogleFonts.changa(
                                            fontSize: 10,
                                            color: Colors.black,
                                            // color: const Color(0xFFFFFADD),
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
                    // NotificationsHelper.notificationsHelper.simpleNotifications(
                    //   id: userId['sender'],
                    //   title: "Message Sent",
                    //   subTitle: sendMassage.text,
                    // );
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
