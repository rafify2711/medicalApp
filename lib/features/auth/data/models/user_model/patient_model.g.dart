// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
  username: json['username'] as String,
  email: json['email'] as String,
  hashedPassword: json['password'] as String,
  phone: json['phone'] as String?,
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  isEmailConfirmed: json['confirmEmail'] as bool?,
  role: json['role'] as String?,
  isDeleted: json['isDeleted'] as bool?,
  profilePhoto: json['profilePhoto'] as String?,
  id: json['_id'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.hashedPassword,
      'phone': instance.phone,
      'gender': _$GenderEnumMap[instance.gender],
      'confirmEmail': instance.isEmailConfirmed,
      'role': instance.role,
      'isDeleted': instance.isDeleted,
      'profilePhoto': instance.profilePhoto,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};
