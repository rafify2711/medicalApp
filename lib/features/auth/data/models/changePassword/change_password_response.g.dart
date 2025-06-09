// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordResponse _$ChangePasswordResponseFromJson(
  Map<String, dynamic> json,
) => ChangePasswordResponse(
  message: json['message'] as String?,
  user:
      json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChangePasswordResponseToJson(
  ChangePasswordResponse instance,
) => <String, dynamic>{'message': instance.message, 'user': instance.user};
