// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDoctorModel _$UpdateDoctorModelFromJson(
  Map<String, dynamic> json,
) => UpdateDoctorModel(
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  bio: json['bio'] as String?,
  experience: (json['experience'] as num?)?.toInt(),
  careerPath:
      (json['careerPath'] as List<dynamic>?)?.map((e) => e as String).toList(),
  highlights:
      (json['highlights'] as List<dynamic>?)?.map((e) => e as String).toList(),
  contact:
      json['contact'] == null
          ? null
          : ContactModel.fromJson(json['contact'] as Map<String, dynamic>),
  gender: json['gender'] as String?,
);

Map<String, dynamic> _$UpdateDoctorModelToJson(UpdateDoctorModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'bio': instance.bio,
      'experience': instance.experience,
      'careerPath': instance.careerPath,
      'highlights': instance.highlights,
      'contact': instance.contact,
      'gender': instance.gender,
    };
