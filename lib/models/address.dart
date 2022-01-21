import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  Address({
    required this.name,
    this.formatedAddress,
    this.latitude,
    this.longitude,
  });

  String name;
  String? formatedAddress;
  double? latitude;
  double? longitude;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
