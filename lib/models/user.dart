import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.name,
    required this.surname,
    this.avatar,
  });

  final String name;
  final String surname;
  final String? avatar;
  @JsonKey(defaultValue: [])
  List<String> joinedEvents = [];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
