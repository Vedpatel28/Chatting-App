import 'package:chat_app_firebase/modal/fire_store_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._pnc();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._pnc();

  String colId = "id";
  String colName = "name";
  String colAge = "age";

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;



  addStudent({required FireStoreModal fireStoreModal}) {
    Map<String, dynamic> data = {
      colId: fireStoreModal.id,
      colName: fireStoreModal.name,
      colAge: fireStoreModal.age,
    };
  }
}
