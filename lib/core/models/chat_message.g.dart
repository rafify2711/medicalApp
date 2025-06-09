// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
  id: json['_id'] as String,
  user: json['user'] as String,
  email: json['email'] as String,
  message: json['message'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num).toInt(),
);

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'email': instance.email,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };

SendMessageData _$SendMessageDataFromJson(Map<String, dynamic> json) =>
    SendMessageData(
      email: json['email'] as String,
      user: json['user'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$SendMessageDataToJson(SendMessageData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'email': instance.email,
      'message': instance.message,
    };
