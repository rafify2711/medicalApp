// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_doctor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDoctorResponse _$UpdateDoctorResponseFromJson(
  Map<String, dynamic> json,
) => UpdateDoctorResponse(
  message: json['message'] as String,
  updatedDoctor: DoctorModel.fromJson(
    json['updatedDoctor'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$UpdateDoctorResponseToJson(
  UpdateDoctorResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'updatedDoctor': instance.updatedDoctor,
};
