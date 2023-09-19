class GetUserModal {
  late int id;
  late String name;
  late String password;
  // late Map received;
  // late Map sent;
  // late List contacts;

  GetUserModal(
    this.id,
    this.name,
    this.password,
    // this.received,
    // this.sent,
    // this.contacts,
  );

  factory GetUserModal.fromMap({required Map data}) {
    return GetUserModal(
      data['id'],
      data['name'],
      data['password'],
      // data['received'],
      // data['sent'],
      // data['contacts'],
    );
  }
}
