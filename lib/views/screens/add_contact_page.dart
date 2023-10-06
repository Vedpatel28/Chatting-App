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
          stream: FireStoreHelper.fireStoreHelper.allUserId(),
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
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
                        "${snap.data[index]['id']}",
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
                        onPressed: () {
                          FireStoreHelper.fireStoreHelper.addContact(
                            userId: argId,
                            addContactId: snap.data[index]['id'],
                          );
                          Navigator.of(context).pop();
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
            } else if (snap.hasError) {
              log("E : ${snap.error}");
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
    );
  }
}
