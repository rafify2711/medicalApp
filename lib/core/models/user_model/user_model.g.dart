// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  username: json['username'] as String?,
  email: json['email'] as String?,
  password: json['password'] as String?,
  phone: json['phone'] as String?,
  gender: json['gender'] as String?,
  role: json['role'] as String?,
  dob: json['DOB'] == null ? null : DateTime.parse(json['DOB'] as String),
  changePasswordTime:
      json['changePasswordTime'] == null
          ? null
          : DateTime.parse(json['changePasswordTime'] as String),
  isDeleted: json['isDeleted'] as bool?,
  profileImage: json['profileImage'] as String?,
  reservations:
      (json['reservations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  id: json['_id'] as String?,
  adress: json['Adress'] as String?,
  medicationHistory:
      (json['medicationHistory'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  v: (json['__v'] as num?)?.toInt(),
  medicalHistory:
      (json['medicalHistory'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'username': instance.username,
  'email': instance.email,
  'password': instance.password,
  'phone': instance.phone,
  'gender': instance.gender,
  'role': instance.role,
  'DOB': instance.dob?.toIso8601String(),
  'changePasswordTime': instance.changePasswordTime?.toIso8601String(),
  'isDeleted': instance.isDeleted,
  'profileImage': instance.profileImage,
  'reservations': instance.reservations,
  '_id': instance.id,
  'Adress': instance.adress,
  'medicationHistory': instance.medicationHistory,
  'medicalHistory': instance.medicalHistory,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  '__v': instance.v,
};
