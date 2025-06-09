// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorsModel _$DoctorsModelFromJson(Map<String, dynamic> json) => DoctorsModel(
  contact: json[''],
  name: json['name'] as String?,
  careerPath: json['careerPath'] as List<dynamic>?,
  highlights: json['highlights'] as List<dynamic>?,
  id: json['_id'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String?,
  specialty: json['specialty'] as String?,
  password: json['password'] as String?,
  phone: json['phone'] as String?,
  gender: json['gender'] as String?,
  changePasswordTime: json['changePasswordTime'] as String?,
  isDeleted: json['isDeleted'] as bool?,
  profilePhoto: json['profilePhoto'] as String?,
  reservations:
      (json['reservations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  schedule:
      (json['schedule'] as List<dynamic>?)
          ?.map((e) => ScheduleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  v: (json['__v'] as num?)?.toInt(),
  role: json['role'] as String?,
  bio: json['bio'] as String?,
  experience: (json['experience'] as num?)?.toInt(),
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$DoctorsModelToJson(DoctorsModel instance) =>
    <String, dynamic>{
      '': instance.contact,
      'name': instance.name,
      'careerPath': instance.careerPath,
      'highlights': instance.highlights,
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'specialty': instance.specialty,
      'password': instance.password,
      'phone': instance.phone,
      'gender': instance.gender,
      'changePasswordTime': instance.changePasswordTime,
      'isDeleted': instance.isDeleted,
      'profilePhoto': instance.profilePhoto,
      'reservations': instance.reservations,
      'schedule': instance.schedule,
      '__v': instance.v,
      'role': instance.role,
      'bio': instance.bio,
      'experience': instance.experience,
      'updatedAt': instance.updatedAt,
    };
