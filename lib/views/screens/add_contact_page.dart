import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddContactsPage extends StatelessWidget {
  const AddContactsPage({super.key});

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
            color: Colors.white,
          ),
        ),
        title: Text(
          "Friend",
          style: GoogleFonts.bubblegumSans(
            fontSize: 28,
            color: const Color(0xFFEEEEEE),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF26577C),
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
                  return Card(
                    child: ListTile(
                      title: Text("${snap.data[index]['id']}",),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
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
            // return ListView.builder(
            //   itemCount: ,
            //   itemBuilder: (context, index) {},
            // );
          },
        ),
      ),
    );
  }
}
