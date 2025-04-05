// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupUserModel _$SignupUserModelFromJson(Map<String, dynamic> json) =>
    SignupUserModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmationPassword: json['confirmationPassword'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$SignupUserModelToJson(SignupUserModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'confirmationPassword': instance.confirmationPassword,
      'role': instance.role,
    };
