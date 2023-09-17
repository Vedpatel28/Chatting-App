class FireStoreModal {
  int id;
  String name;
  int age;

  FireStoreModal(
    this.id,
    this.name,
    this.age,
  );

  factory FireStoreModal.fromMap({required Map data}) {
    return FireStoreModal(
      data['id'],
      data['name'],
      data['age'],
    );
  }
}
