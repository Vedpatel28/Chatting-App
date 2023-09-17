import 'package:firebase_auth/firebase_auth.dart';

class UserModal {
  String? userName;
  String? userEmail;
  String? userImage;

  UserModal({
    this.userName,
    this.userEmail,
    this.userImage,
  });

  factory UserModal.fromMap({required Map data}) {
    return UserModal(
      userEmail: data['userEmail'],
      userName: data['userEmail'],
      userImage: data['userImage'],
    );
  }
}
