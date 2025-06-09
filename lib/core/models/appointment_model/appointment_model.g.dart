// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      doctor: Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      timeSlot: json['timeSlot'] as String?,
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'status': instance.status,
      'doctor': instance.doctor,
      'user': instance.user,
      'timeSlot': instance.timeSlot,
    };

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
  id: json['id'] as String,
  name: json['name'] as String,
  specialization: json['specialization'] as String,
);

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'specialization': instance.specialization,
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
};
