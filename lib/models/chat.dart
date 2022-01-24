import 'package:json_annotation/json_annotation.dart';
import 'package:party/models/message.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  Chat({
    required this.messages,
  });

  @JsonKey(defaultValue: [])
  List<Message> messages;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
