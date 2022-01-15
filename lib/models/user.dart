class User {
  User({
    required this.name,
    required this.surname,
    this.avatar,
  });

  final String name;
  final String surname;
  final String? avatar;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      surname: json["surname"],
      avatar: json["avatar"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "surname": surname,
      "avatar": avatar,
    };
  }
}
