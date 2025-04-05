// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupDoctorModel _$SignupDoctorModelFromJson(Map<String, dynamic> json) =>
    SignupDoctorModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmationPassword: json['confirmationPassword'] as String,
      role: json['role'] as String,
      specialty: json['specialty'] as String,
    );

Map<String, dynamic> _$SignupDoctorModelToJson(SignupDoctorModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'confirmationPassword': instance.confirmationPassword,
      'role': instance.role,
      'specialty': instance.specialty,
    };
