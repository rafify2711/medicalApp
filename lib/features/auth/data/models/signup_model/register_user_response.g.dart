// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterUserResponse _$RegisterUserResponseFromJson(
  Map<String, dynamic> json,
) => RegisterUserResponse(
  json['message'] as String,
  UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RegisterUserResponseToJson(
  RegisterUserResponse instance,
) => <String, dynamic>{'message': instance.message, 'user': instance.user};
