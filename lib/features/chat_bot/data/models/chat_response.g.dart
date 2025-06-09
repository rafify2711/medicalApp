// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
  userMessage: ChatMessage.fromJson(json['newMessage'] as Map<String, dynamic>),
  botMessage: ChatMessage.fromJson(json['botMessage'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'newMessage': instance.userMessage,
      'botMessage': instance.botMessage,
    };
