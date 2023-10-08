import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddContactsPage extends StatelessWidget {
  AddContactsPage({super.key});

  int argId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            shadows: [
              BoxShadow(
                offset: Offset(1.4, 0.9),
                color: Colors.black26,
              ),
            ],
          ),
        ),
        title: Text(
          "Add Friend",
          style: GoogleFonts.bubblegumSans(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 26,
              shadows: [
                BoxShadow(
                  offset: Offset(1.4, 0.9),
                  color: Colors.black26,
                ),
              ],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.getAllUserStream(id: argId),
          builder: (context, snap) {
            if (snap.hasData) {
              return StreamBuilder(
                stream: FireStoreHelper.fireStoreHelper.allUserId(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List allId = snapshot.data;
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1.6, 1.1),
                                color: Colors.black26,
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              "${allId[index]['id']} ",
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
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                log("Se : ${allId[index]['id']}");
                                Map data = {
                                  'sender': snap.data?['contacts'],
                                  'recieved': snap.data,
                                };

                                FireStoreHelper.fireStoreHelper.addContact(
                                  userId: argId,
                                  addContactId: allId[index]['id'],
                                );
                                Get.snackbar(
                                  "Added Successful",
                                  "Chat Started",
                                  duration: const Duration(milliseconds: 300),
                                );

                                Get.toNamed(
                                  "/HomePage",
                                );
                                // Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                                shadows: [
                                  BoxShadow(
                                    offset: Offset(1.4, 0.9),
                                    color: Colors.black26,
                                  ),
                                ],
                                size: 40,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            } else if (snap.hasError) {
              return Center(
                child: Text("${snap.error}"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      backgroundColor: Colors.blueGrey.shade50,
    );
  }
}
