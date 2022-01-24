import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  Message({
    required this.content,
    required this.displayName,
    required this.userId,
  });

  final String content;
  final String userId;
  final String displayName;
  final DateTime sent = DateTime.now();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
