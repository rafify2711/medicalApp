import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  @JsonKey(name: '_id')
  final String id;
  final String user;
  final String email;
  final String message;
  final DateTime timestamp;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int version;

  ChatMessage({
    required this.id,
    required this.user,
    required this.email,
    required this.message,
    required this.timestamp,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}


@JsonSerializable()
class SendMessageData{

  final String user;
  final String email;
  final String message;

  SendMessageData({required this.email,required this.user,required this.message});

  factory SendMessageData.fromJson(Map<String, dynamic> json) =>
      _$SendMessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageDataToJson(this);

}

