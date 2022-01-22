import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  Place({
    required this.name,
    this.formattedAddress,
    this.latitude,
    this.longitude,
    required this.reference,
  });

  String name;
  String? formattedAddress;
  double? latitude;
  double? longitude;
  String reference;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
