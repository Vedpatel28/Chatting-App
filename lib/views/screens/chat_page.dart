// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:chat_app_firebase/modal/chat_modal.dart';
import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
            shadows: [
              BoxShadow(
                offset: Offset(1.4, 0.9),
                color: Colors.black26,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        // Receiver Name
        title: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.userStream(
            recievedId: userId['sender'],
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Receiver Name

              var name = snapshot.data;

              return Text(
                "${name['name']}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  shadows: [
                    BoxShadow(
                      offset: Offset(1.4, 0.9),
                      color: Colors.black26,
                    ),
                  ],
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
                  Map<String, dynamic>? data =
                      snapshot.data as Map<String, dynamic>?;
                  // All Fire Base Data Facing
                  if (snapshot.hasData) {
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
                        return dt;
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
                        return dt;
                      },
                    ).toList();

                    List<ChatModal> allChat =
                        List.generate(sentChat!.length, (index) {
                      return ChatModal(
                        sentChat[index],
                        sTime[index],
                        "sent",
                      );
                    });

                    allChat.addAll(
                      List.generate(
                        recievedChat!.length,
                        (index) {
                          return ChatModal(
                            recievedChat[index],
                            rTime[index],
                            "received",
                          );
                        },
                      ),
                    );
                    allChat.sort((a, b) => a.time.isAfter(b.time) ? 1 : 0);

                    return ListView.builder(
                      // Check Length
                      itemCount: allChat.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            // Sent Chat
                            Row(
                              mainAxisAlignment: allChat[index].type == "sent"
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onDoubleTap: () {
                                    log("${sentChat[index]}");
                                    int chatIndex =
                                        sentChat.indexOf(sentChat[index]);
                                    log("{[ $chatIndex");
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
                                        return const CupertinoAlertDialog();
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 300,
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 5,
                                      top: 5,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        // Decoration Sent Chat Box
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: allChat[index].type ==
                                                    "received"
                                                ? const Color(0xFFEBE4D1)
                                                : const Color(0xFFB0D9B1),
                                            borderRadius:
                                                BorderRadius.horizontal(
                                              left: allChat[index].type ==
                                                      "received"
                                                  ? const Radius.circular(20)
                                                  : const Radius.circular(0),
                                              right: allChat[index].type ==
                                                      "sent"
                                                  ? const Radius.circular(20)
                                                  : const Radius.circular(0),
                                            ),
                                          ),
                                          alignment:
                                              allChat[index].type == "received"
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                          // Sent Chat
                                          child: Column(
                                            crossAxisAlignment:
                                                allChat[index].type ==
                                                        "received"
                                                    ? CrossAxisAlignment.end
                                                    : CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${allChat[index].chat}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  shadows: [
                                                    BoxShadow(
                                                      offset: Offset(1.4, 0.9),
                                                      color: Colors.black26,
                                                    ),
                                                  ],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${allChat[index].time.hour}:${allChat[index].time.minute}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  shadows: [
                                                    BoxShadow(
                                                      offset: Offset(1.4, 0.9),
                                                      color: Colors.black26,
                                                    ),
                                                  ],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
              onSubmitted: (value) {
                FireStoreHelper.fireStoreHelper.sentNewMassage(
                  sentId: userId['sender'],
                  receiverId: userId['recieved']['id'],
                  msg: sendMassage.text,
                );
                sendMassage.clear();
              },
              controller: sendMassage,
              textInputAction: TextInputAction.send,
              cursorHeight: 30,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF0D1282).withOpacity(0.2),
                hintText: "Message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey.shade50,
    );
  }
}
