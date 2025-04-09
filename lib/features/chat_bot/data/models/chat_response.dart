import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/chat_message.dart';

part 'chat_response.g.dart';

@JsonSerializable()
class ChatResponse {
  @JsonKey(name: 'newMessage')
  final ChatMessage userMessage;

  @JsonKey(name: 'botMessage')
  final ChatMessage botMessage;

  ChatResponse({
    required this.userMessage,
    required this.botMessage,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}