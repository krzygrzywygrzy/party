// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      content: json['content'] as String,
      displayName: json['displayName'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'content': instance.content,
      'userId': instance.userId,
      'displayName': instance.displayName,
    };
