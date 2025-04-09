
import 'package:json_annotation/json_annotation.dart';


part 'appointment_model.g.dart';

@JsonSerializable()
class AppointmentModel {
  final String id;
  final DateTime date;
  final String status;
  final Doctor doctor;
  final User user;
  final String? timeSlot;

  AppointmentModel({
    required this.id,
    required this.date,
    required this.status,
    required this.doctor,
    required this.user,
    this.timeSlot
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}



@JsonSerializable()
class Doctor {
  final String id;
  final String name;
  final String specialization;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) =>
      _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}

@JsonSerializable()
class User {
  final String id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}


