import 'dart:developer';

import 'package:chat_app_firebase/modal/fire_store_modal.dart';
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

  Stream<dynamic> getAllUser({required int id}) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> data =
        firebaseFireStore.collection(collection).doc("$id").snapshots();

    Stream<dynamic> allData = data.map((event) => event.data());

    return allData;
  }

  addUser({required FireStoreModal fireStoreModal}) {
    Map<String, dynamic> data = {
      "name": fireStoreModal.name,
      "id": fireStoreModal.id,
      "password": fireStoreModal.password,
    };

    firebaseFireStore
        .collection(collection)
        .doc("${fireStoreModal.id}")
        .set(data);
  }

  Stream<dynamic> userStream({required int recievedId}) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> data =
        firebaseFireStore.collection(collection).doc("$recievedId").snapshots();

    Stream<dynamic> allData = data.map((event) => event.data());

    return allData;
  }

  sentNewMassage ({required int sentId , required int receiverId,required String msg}) {



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
