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

    return doc.data() as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>?> getAllUser({required int id}) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await firebaseFireStore.collection(collection).doc("$id").get();

    Map<String, dynamic>? allData = data.data();
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
      "contacts": [],
      "recieved": {
        "102": {
          "msg": [""],
          "time": [""],
        }
      },
      "sent": {
        "102": {
          "msg": [""],
          "time": [""],
        }
      },
    };

    firebaseFireStore
        .collection(collection).doc("${fireStoreModal.id}").set(data);
  }

  Stream<dynamic> userStream({required int recievedId}) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> data =
        firebaseFireStore.collection(collection).doc("$recievedId").snapshots();

    Stream allData = data.map((event) => event.data());
    return allData;
  }

  addContact({
    required int userId,
    required int addContactId,
  }) async {
    Map<String, dynamic>? allUser = await getAllUser(id: userId);
    allUser?['contacts'].add(addContactId);
    firebaseFireStore.collection(collection).doc('$userId').set(allUser!);
  }

  removeContact({
    required int userId,
    required String removedContactId,
  }) async {
    Map<String, dynamic>? allUser = await getAllUser(id: userId);
    allUser?['contacts'].remove(removedContactId);
    firebaseFireStore.collection(collection).doc('$userId').set(allUser!);
  }

  updateChat({
    required int sentId,
    required int receicerId,
    required int sentChatIndex,
    required int receivedChatIndex,
    required String newChat,
  }) async {
    Map<String, dynamic>? sender = await getAllUser(id: sentId);
    Map<String, dynamic>? receiver = await getAllUser(id: receicerId);

    sender?['sent']['$receicerId']['msg'][sentChatIndex] = newChat;
    receiver?['recieved']['$sentId']['msg'][receivedChatIndex] = newChat;

    firebaseFireStore.collection(collection).doc('$sentId').set(sender!);
    firebaseFireStore.collection(collection).doc('$receicerId').set(receiver!);
  }

  deleteChat({
    required int sentId,
    required int receicerId,
    required int chatIndex,
  }) async {
    Map<String, dynamic>? sender = await getAllUser(id: sentId);
    Map<String, dynamic>? receiver = await getAllUser(id: receicerId);

    log(" S = ${sender?['sent']['$receicerId']['msg']}");
    log(" R = ${receiver?['recieved']['$sentId']['msg']}");

    sender?['sent']['$receicerId']['msg'].removeAt(chatIndex);
    sender?['sent']['$receicerId']['time'].removeAt(chatIndex);

    receiver?['recieved']['$sentId']['msg'].removeAt(chatIndex);
    receiver?['recieved']['$sentId']['time'].removeAt(chatIndex);

    firebaseFireStore.collection(collection).doc('$sentId').set(sender!);
    firebaseFireStore.collection(collection).doc('$receicerId').set(receiver!);
  }

  sentNewMassage({
    required int sentId,
    required int receiverId,
    required String msg,
  }) async {

    Map<String, dynamic>? sender = await getAllUser(id: sentId);
    Map<String, dynamic>? receiver = await getAllUser(id: receiverId);

    DateTime d = DateTime.now();
    String time = "${d.day}/${d.month}/${d.year}-${d.hour}:${d.minute}:${d.second}";

    sender?['sent']['$receiverId']['msg'].add(msg);
    sender?['sent']['$receiverId']['time'].add(time);

    receiver?['recieved']['$sentId']['msg'].add(msg);
    receiver?['recieved']['$sentId']['time'].add(time);

    firebaseFireStore
        .collection(collection)
        .doc(sentId.toString())
        .set(sender!);
    firebaseFireStore
        .collection(collection)
        .doc(receiverId.toString())
        .set(receiver!);
  }

  getContacts({required int id}) async {
    Map<String, dynamic> user = await getUser(id: id);

    return user['contacts'];
  }

  validateUser({required int id, required String password}) async {
    DocumentSnapshot doc =
        await firebaseFireStore.collection(collection).doc(id.toString()).get();

    if (doc["id"] == id) {
      log("ID Is Fund");
      if (doc["password"] == password) {
        log("Password Check");
      }
    } else {
      log("ID Not Exist");
    }
    return doc.data();
  }

  getCredential({required int id}) async {
    DocumentSnapshot snapshot =
        await firebaseFireStore.collection(collection).doc(id.toString()).get();

    Map<dynamic, dynamic> data = snapshot.data() as Map;

    return data["password"];
  }
}
