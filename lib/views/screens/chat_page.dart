// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:chat_app_firebase/modal/chat_modal.dart';
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
                  Map<String, dynamic>? data =
                      snapshot.data as Map<String, dynamic>?;
                  // All Fire Base Data Facing
                  if (snapshot.hasData) {
                    log("a;; Data : ${data}");
                    // All Sent Chat
                    List<dynamic>? sentChat =
                        data!['sent']['${userId['recieved']['id']}']['msg'];

                    log("Sent Data : ${sentChat}");

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
                    allChat.forEach((element) {
                      log(" T :: ${element.chat}");
                    });

                    log("Length : ${allChat.length}");

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
                                          alignment:
                                              allChat[index].type == "sent"
                                                  ? Alignment.topLeft
                                                  : Alignment.topRight,
                                          // Sent Chat
                                          child: Text(
                                            allChat[index].chat,
                                            style: GoogleFonts.bitter(
                                              fontSize: 22,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        // Transform.translate(
                                        //   offset: const Offset(130, 0),
                                        //   child: Text(
                                        //     "${allChat[index].time}",
                                        //     style: GoogleFonts.changa(
                                        //       fontSize: 12,
                                        //       color: Colors.black,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // // Received Chat
                            // Row(
                            //   mainAxisAlignment:
                            //       allChat[index].type == "received"
                            //           ? MainAxisAlignment.start
                            //           : MainAxisAlignment.end,
                            //   children: [
                            //     Container(
                            //       padding: const EdgeInsets.only(
                            //         left: 10,
                            //         right: 10,
                            //         bottom: 5,
                            //         top: 5,
                            //       ),
                            //       margin: const EdgeInsets.all(6),
                            //       decoration: const BoxDecoration(
                            //         borderRadius: BorderRadius.only(
                            //           bottomRight: Radius.circular(25),
                            //           topRight: Radius.circular(25),
                            //           bottomLeft: Radius.circular(25),
                            //         ),
                            //         // color: Color(0xFFF2F2F0),
                            //       ),
                            //       alignment: Alignment.center,
                            //       child: Column(
                            //         children: [
                            //           // Decoration Received Chat Box
                            //           Container(
                            //             width: s.width * 0.8,
                            //             alignment: Alignment.topLeft,
                            //             // Received Chat Box
                            //             child: Text(
                            //                "${allChat[index]}",
                            //               style: GoogleFonts.changa(
                            //                 color: Colors.black,
                            //                 fontSize: 22,
                            //                 fontWeight: FontWeight.w500,
                            //               ),
                            //             ),
                            //           ),
                            //           // Transform.translate(
                            //           //   offset: const Offset(-140, 0),
                            //           //   child: Text(
                            //           //     "${rTime[index]}",
                            //           //     style: GoogleFonts.changa(
                            //           //       fontSize: 10,
                            //           //       color: Colors.black,
                            //           //       // color: const Color(0xFFFFFADD),
                            //           //     ),
                            //           //   ),
                            //           // ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
    );
  }
}
