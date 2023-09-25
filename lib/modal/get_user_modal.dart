class GetUserModal {
  late int id;
  late String name;
  late String password;
  late String status = "offline";
  late List contacts = [];
  late Map received = {
    "${contacts[0]}": {
      "msg": [],
      "time": [],
    }
  };
  late Map sent = {
    "${contacts[0]}": {
      "msg": [],
      "time": [],
    }
  };

  GetUserModal(
    this.id,
    this.name,
    this.password,
    this.status,
    this.contacts,
    this.received,
    this.sent,
  );

  factory GetUserModal.fromMap({required Map data}) {
    return GetUserModal(
      data['id'],
      data['name'],
      data['status'],
      data['password'],
      data['contacts'],
      data['received'],
      data['sent'],
    );
  }
}
