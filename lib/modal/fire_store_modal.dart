class FireStoreModal {
  int id;
  String name;
  String password;
  // late List contacts = [];
  // late Map received = {
  //   "${contacts[0]}": {
  //     "msg" : "",
  //     "time" : "",
  //   }
  // };
  // late Map sent = {
  //   "${contacts[0]}": {
  //     "msg" : "",
  //     "time" : "",
  //   }
  // };

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
