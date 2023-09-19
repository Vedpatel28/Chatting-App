import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._pnc();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._pnc();

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  String collection = "Users";

  Future<Map<String, dynamic>> getUser({required int id}) async {
    DocumentSnapshot doc =
        await firebaseFireStore.collection(collection).doc('$id').get();

    return doc.data() as Map<String, dynamic>;
  }

  getContacts({required int id}) async {
    Map<String, dynamic> user = await getUser(id: id);

    return user['contacts'];
  }



  getCredential({required int id}) async {
    DocumentSnapshot snapshot =
        await firebaseFireStore.collection(collection).doc(id.toString()).get();

    log("SnapShort = $snapshot");
    Map<dynamic, dynamic> data = snapshot.data() as Map;
    log(" Data = $data");

    return data["password"];
  }
}
