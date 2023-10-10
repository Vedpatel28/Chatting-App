import 'dart:developer';

import 'package:chat_app_firebase/modal/fire_store_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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

  getUserNameUsingContact({required int con}) async {
    Map<String, dynamic>? user = await getUser(id: con);

    log('{[ ${user['name']}');

    return user;
  }

  Future<Map<String, dynamic>?> getAllUser({required int id}) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await firebaseFireStore.collection(collection).doc("$id").get();

    Map<String, dynamic>? allData = data.data();
    return allData;
  }

  Stream allUserId() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data =
        firebaseFireStore.collection(collection).snapshots();

    Stream<dynamic> allData = data.map((event) => event.docs);

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
        "001": {
          "msg": ["HI User"],
          "time": ["28/09/23-10:10:10"],
        }
      },
      "sent": {
        "001": {
          "msg": ["Hello AI"],
          "time": ["28/09/23-10:10:11"],
        }
      },
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
    return allData;
  }

  addContact({required int userId, required int addContactId,}) async {
    Map<String, dynamic>? newAllUser = await getAllUser(id: userId);
    Map<String, dynamic>? oldAllUser = await getAllUser(id: addContactId);
    Map<String, dynamic> oldInContact = {
      '$addContactId': {
        "msg": ["Hi"],
        "time": ["0/00/0000-00:00:00"],
      }
    };
    Map<String, dynamic> newInContact = {
      '$userId': {
        "msg": ["Hello"],
        "time": ["0/00/0000-00:00:00"],
      }
    };

    newAllUser?['recieved'].addAll(oldInContact);
    newAllUser?['sent'].addAll(oldInContact);

    oldAllUser?['recieved'].addAll(newInContact);
    oldAllUser?['sent'].addAll(newInContact);


    newAllUser?['contacts'].add(addContactId);
    oldAllUser?['contacts'].add(userId);

    firebaseFireStore.collection(collection).doc('$userId').set(newAllUser!);
    firebaseFireStore.collection(collection).doc('$addContactId').set(oldAllUser!);
  }

  removeContact({
    required int userId,
    required int removeContact,
  }) async {

    Map<String, dynamic>? newAllUser = await getAllUser(id: userId);
    Map<String, dynamic>? oldAllUser = await getAllUser(id: removeContact);

    log("CU ID : $userId");
    log("RE ID : $removeContact");

    log("ALL CUR ${newAllUser?['contacts']}");
    log("ALL REM ${oldAllUser?['contacts']}");

    oldAllUser?['contacts'].remove(userId);
    newAllUser?['contacts'].remove(removeContact);

    firebaseFireStore.collection(collection).doc('$userId').set(newAllUser!);
    firebaseFireStore.collection(collection).doc('$removeContact').set(oldAllUser!);
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

    log("O S = ${sender?['sent']['$receicerId']['msg'][sentChatIndex]}");
    log("O R = ${receiver?['recieved']['$sentId']['msg'][receivedChatIndex]}");

    sender?['sent']['$receicerId']['msg'][sentChatIndex] = newChat;
    receiver?['recieved']['$sentId']['msg'][receivedChatIndex] = newChat;

    log("N S = ${sender?['sent']['$receicerId']['msg'][sentChatIndex]}");
    log("N R = ${receiver?['recieved']['$sentId']['msg'][receivedChatIndex]}");

    firebaseFireStore.collection(collection).doc('$sentId').set(sender!);
    firebaseFireStore.collection(collection).doc('$receicerId').set(receiver!);
  }

  updateProfile({
    String? name,
    String? password,
    int? id,
  }) async {
    Map<String, dynamic>? sender = await getAllUser(id: id!);
    log(" S = ${sender?['name']}");

    sender?['name'] = name;
    sender?['password'] = password;

    log("A F S = ${sender?['name']}");
    log("A F S = ${sender?['password']}");

    firebaseFireStore.collection(collection).doc('$id').set(sender!);

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
    String time =
        "${d.day}/${d.month}/${d.year}-${d.hour}:${d.minute}:${d.second}";

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

  validateUser({required int id, required String password}) async {
    DocumentSnapshot doc =
        await firebaseFireStore.collection(collection).doc(id.toString()).get();

    if (doc["id"] == id) {
      log("ID Is Fund");
      if (doc["password"] == password) {
        log("Password Check");
      }
    } else {
      Get.snackbar("Failed", "User Can't Axis..");
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

  getAllContacts({required int id}) async {
    DocumentSnapshot snapshot =
        await firebaseFireStore.collection(collection).doc(id.toString()).get();

    Map<dynamic, dynamic> data = snapshot.data() as Map;

    return data["contacts"];
  }
}
