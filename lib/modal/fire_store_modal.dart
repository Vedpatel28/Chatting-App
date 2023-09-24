class FireStoreModal {
  int id;
  String name;
  String password;
  // List contacts = [];
  // late Map sent = {
  //   "${contacts[0]}": {
  //     "msg": "",
  //     "time": "",
  //   }
  // };
  // late Map received = {
  //   "${contacts[0]}": {
  //     "msg": "",
  //     "time": "",
  //   }
  // };

  FireStoreModal(
    this.id,
    this.name,
    this.password,
    // this.contacts,
    // this.sent,
    // this.received,
  );

  factory FireStoreModal.fromMap({required Map data}) {
    return FireStoreModal(
      data['id'],
      data['name'],
      data['password'],
      // data['contacts'],
      // data['sent'],
      // data['received'],
    );
  }
}
