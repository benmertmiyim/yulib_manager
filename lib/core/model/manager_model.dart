class Manager {
  final String uid;
  final String email;
  final String nameSurname;

  Manager({
    required this.uid,
    required this.email,
    required this.nameSurname,
  });

  @override
  String toString() {
    return 'Manager{uid: $uid, email: $email, nameSurname: $nameSurname}';
  }
}
