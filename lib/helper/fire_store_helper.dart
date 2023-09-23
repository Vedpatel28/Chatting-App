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

  Future<Map<String, dynamic>?> getAllUser({required int id}) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await firebaseFireStore.collection(collection).doc("$id").get();

    Map<String, dynamic>? allData = data.data();
    // List<QueryDocumentSnapshot> allData = data.data() as List<QueryDocumentSnapshot<Object?>>;

    // List<GetUserModal> allUser = allData!.map((e) => GetUserModal.fromMap(data: e.data() as Map));

    log("User : [${allData}] \n That After : ");

    return allData;
  }

  Stream<dynamic> getAllUserStream({required int id}) {
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

    Stream allData = data.map((event) => event.data());
    log("Contact Name :  $allData");
    return allData;
  }

  sentNewMassage({
    required int sentId,
    required int receiverId,
    required String msg,
  }) async {

    Map<String, dynamic>? sender = await getAllUser(id: sentId);

    Map<String, dynamic>? receiver = await getAllUser(id: receiverId);

    DateTime d = DateTime.now();
    String time = "${d.day}/${d.month}/${d.year}-${d.hour}:${d.minute}";

    sender?['sent']['$receiverId']['msg'].add(msg);
    sender?['sent']['$receiverId']['time'].add(time);

      log("after Sent : ${sender?['sent']['$receiverId']['msg']}");

    receiver?['recieved']['$sentId']['msg'].add(msg);
    receiver?['recieved']['$sentId']['time'].add(time);

      log("after Sent : ${sender?['sent']['$receiverId']['msg']}");

    firebaseFireStore.collection(collection).doc(sentId.toString()).set(sender!);
    firebaseFireStore.collection(collection).doc(receiverId.toString()).set(receiver!);
  }

  getContacts({required int id}) async {
    Map<String, dynamic> user = await getUser(id: id);

    return user['contacts'];
  }

  validateUser({required int id, required String password}) async {
    DocumentSnapshot doc =
        await firebaseFireStore.collection(collection).doc(id.toString()).get();
    log("Doc = ${doc['id']}");

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
