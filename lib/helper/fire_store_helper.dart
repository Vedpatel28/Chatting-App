import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._pnc();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._pnc();

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  String collection = "Users";

  Stream<DocumentSnapshot> getUser({required int id}) {
    return firebaseFireStore
        .collection(collection)
        .doc(id.toString())
        .snapshots();
  }

  getCredential({required int id}) async {
    DocumentSnapshot snapshot =
        await firebaseFireStore.collection(collection).doc(id.toString()).get();

    Map data = snapshot.data() as Map;

    return data["password"];
  }

// addStudent({required FireStoreModal fireStoreModal}) {
//   final user = <String, dynamic>{
//     "age": fireStoreModal.age,
//     "id": fireStoreModal.id,
//     "name": fireStoreModal.name,
//   };
//   db.collection("student").add(user).then(
//         (DocumentReference doc) => log(
//           'DocumentSnapshot added with ID: ${doc.id}',
//         ),
//       );
// }
//
// addData() {
//   final user = <String, dynamic>{
//     "age": 19,
//     "id": 102,
//     "name": "ved",
//   };
//   db.collection("student").add(user).then(
//         (DocumentReference doc) =>
//             log('DocumentSnapshot added with ID: ${doc.id}'),
//       );
// }
//
// readData() async {
//   return await db.collection("users").get().then((event) {
//     for (var doc in event.docs) {
//       log("${doc.id} => ${doc.data()}");
//     }
//   });
// }
}
