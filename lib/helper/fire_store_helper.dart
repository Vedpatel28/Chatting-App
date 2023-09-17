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

  String collection = "student";
  String count = "count";

  addStudent({required FireStoreModal fireStoreModal}) {
    Map<String, dynamic> data = {
      colId: fireStoreModal.id,
      colName: fireStoreModal.name,
      colAge: fireStoreModal.age,
    };

    firebaseFireStore.collection(collection).add(data).then(
          (value) => log("Student Added : ${value.id}"),
        );
  }

  Future<List<FireStoreModal>> getAllStudent() async {
    QuerySnapshot data = await firebaseFireStore.collection(collection).get();

    List<QueryDocumentSnapshot> allData = data.docs;

    List<FireStoreModal> allStudent = allData
        .map((e) => FireStoreModal.fromMap(data: e.data() as Map))
        .toList();

    return allStudent;
  }

  Future<int> getCounter() async {
    QuerySnapshot data = await firebaseFireStore.collection(collection).get();

    List<QueryDocumentSnapshot> doc = data.docs;

    Map<String, dynamic> count = doc[0].data() as Map<String, dynamic>;

    int idCount = count['val'];

    log("Id count: $idCount");

    return idCount;
  }

  Future<int> increaseId() async {
    int id = await getCounter();

    Map<String, dynamic> data = {
      'val': ++id,
    };

    firebaseFireStore.collection(count).doc('count').set(data);

    return id;
  }
}
