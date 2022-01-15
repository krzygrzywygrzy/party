class User {
  User({
    required this.name,
    required this.surname,
    this.avatar,
  });

  final String name;
  final String surname;
  final String? avatar;
}
