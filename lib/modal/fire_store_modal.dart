class FireStoreModal {
  int id;
  String name;
  String password;

  FireStoreModal(
    this.id,
    this.name,
    this.password,
  );

  factory FireStoreModal.fromMap({required Map data}) {
    return FireStoreModal(
      data['id'],
      data['name'],
      data['password'],
    );
  }
}
