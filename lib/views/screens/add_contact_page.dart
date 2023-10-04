import 'dart:developer';

import 'package:chat_app_firebase/helper/fire_store_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddContactsPage extends StatelessWidget {
  const AddContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Friend",
          style: GoogleFonts.bubblegumSans(
            fontSize: 22,
            color: const Color(0xFFEEEEEE),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF26577C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
          future: FireStoreHelper.fireStoreHelper.allUserId(),
          builder: (context, snap) {
            if (snap.hasData) {
              return Container();
            } else if (snap.hasError) {
              log("${snap.error}");
              return Center(
                child: Text("${snap.data}"),
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
