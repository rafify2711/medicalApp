// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordData _$ResetPasswordDataFromJson(Map<String, dynamic> json) =>
    ResetPasswordData(
      email: json['email'] as String,
      otp: json['otp'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$ResetPasswordDataToJson(ResetPasswordData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
    };
