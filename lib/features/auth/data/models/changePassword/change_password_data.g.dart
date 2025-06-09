// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordData _$ChangePasswordDataFromJson(Map<String, dynamic> json) =>
    ChangePasswordData(
      oldPassword: json['oldPassword'] as String,
      newPassword: json['newPassword'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$ChangePasswordDataToJson(ChangePasswordData instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
