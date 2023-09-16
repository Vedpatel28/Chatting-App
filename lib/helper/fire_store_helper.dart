import 'dart:developer';

import 'package:chat_app_firebase/modal/fire_store_modal.dart';
import 'package:chat_app_firebase/modal/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._pnc();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._pnc();

  String colId = "id";
  String colName = "name";
  String colAge = "age";

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  CollectionReference user = FirebaseFirestore.instance.collection("student");

  String collect = "student";
  String count = "count";

  addStudent({required FireStoreModal fireStoreModal}) {
    // Map<String, dynamic> data = {
    //   colId: fireStoreModal.id,
    //   colName: fireStoreModal.name,
    //   colAge: fireStoreModal.age,
    // };

    return user
        .add({
          colId: fireStoreModal.id,
          colName: fireStoreModal.name,
          colAge: fireStoreModal.age,
        })
        .then((value) => log("User Added in Fire Base"))
        .catchError((error) => log("User Added in Fire Base : $error"));
  }

  getCounter() {
    QuerySnapshot data =
        firebaseFireStore.collection("count").get() as QuerySnapshot<Object?>;

    List<QueryDocumentSnapshot> doc = data.docs;

    Map<String, dynamic> count = doc[0].data() as Map<String, dynamic>;

    int idCount = count['val'];

    return idCount;
  }

  increaseId() async {
    int id = await getCounter();

    Map<String, dynamic> data = {
      'val': ++id,
    };

    firebaseFireStore.collection(count).doc('count').set(data);
  }
}
