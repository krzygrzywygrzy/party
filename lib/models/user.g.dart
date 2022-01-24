// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      surname: json['surname'] as String,
      avatar: json['avatar'] as String?,
    )..joinedEvents = (json['joinedEvents'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [];

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'avatar': instance.avatar,
      'joinedEvents': instance.joinedEvents,
    };
