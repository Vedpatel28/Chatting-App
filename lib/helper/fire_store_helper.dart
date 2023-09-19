import 'dart:developer';

import 'package:chat_app_firebase/modal/get_user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._pnc();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._pnc();

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  String collection = "Users";

  Future<Map<String, dynamic>> getUser({required int id}) async {
    DocumentSnapshot doc =
        await firebaseFireStore.collection(collection).doc('$id').get();

    log("Print : ${doc.data()}");
    return doc.data() as Map<String, dynamic>;
  }

  Future<List<GetUserModal>> getAllUser() async {
    QuerySnapshot data = await firebaseFireStore.collection(collection).get();

    List<QueryDocumentSnapshot> allData = data.docs;

    List<GetUserModal> allUser = allData
        .map((e) => GetUserModal.fromMap(data: e.data() as Map))
        .toList();

    log("User : [$allUser] $allUser");

    return allUser;
  }

  getContacts({required int id}) async {
    Map<String, dynamic> user = await getUser(id: id);

    return user['contacts'];
  }

  validateUser({required int id, required String password}) async {
    DocumentSnapshot doc =
        await firebaseFireStore.collection(collection).doc(id.toString()).get();
    log("Doc = $doc");

    if (doc["id"] == id) {
      log("ID Is Fund");
      if (doc["password"] == password) {
        log("Password Check");
      }
    } else {
      log("ID Not Exist");
    }
    log("Doc Withe Data = ${doc.data()}");
    return doc.data();
  }

  getCredential({required int id}) async {
    DocumentSnapshot snapshot =
        await firebaseFireStore.collection(collection).doc(id.toString()).get();

    Map<dynamic, dynamic> data = snapshot.data() as Map;
    log("SnapShort = $data");

    return data["password"];
  }
}
