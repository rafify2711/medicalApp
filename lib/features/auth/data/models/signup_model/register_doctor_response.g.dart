// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_doctor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDoctorResponse _$RegisterDoctorResponseFromJson(
  Map<String, dynamic> json,
) => RegisterDoctorResponse(
  json['message'] as String,
  DoctorModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RegisterDoctorResponseToJson(
  RegisterDoctorResponse instance,
) => <String, dynamic>{'message': instance.message, 'user': instance.user};
