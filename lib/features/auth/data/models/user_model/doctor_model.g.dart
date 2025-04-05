// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  username: json['username'] as String,
  email: json['email'] as String,
  hashedPassword: json['password'] as String,
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  role: json['role'] as String?,
  isDeleted: json['isDeleted'] as bool?,
  profilePhoto: json['profilePhoto'] as String?,
  id: json['_id'] as String?,
  specialty: json['specialty'] as String,
  schedule:
      (json['schedule'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.hashedPassword,
      'gender': _$GenderEnumMap[instance.gender],
      'role': instance.role,
      'isDeleted': instance.isDeleted,
      'profilePhoto': instance.profilePhoto,
      'specialty': instance.specialty,
      'schedule': instance.schedule,
      '_id': instance.id,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};
