class FireStoreModal {
  int id;
  String name;
  String password;
  // late Map received;
  // late Map sent;
  // late List contacts;

  FireStoreModal(
    this.id,
    this.name,
    this.password,
    // this.received,
    // this.sent,
    // this.contacts,
  );

  factory FireStoreModal.fromMap({required Map data}) {
    return FireStoreModal(
      data['id'],
      data['name'],
      data['password'],
      // data['received'],
      // data['sent'],
      // data['contacts'],
    );
  }
}
