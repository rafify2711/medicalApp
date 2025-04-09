import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorModel {
  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String email;
  final String specialty;
  final String gender;
  final String? phone;
  @JsonKey(name: 'profilePhoto')
  final String? profilePhoto;
  @JsonKey(name: 'changePasswordTime')
  final DateTime? changePasswordTime;
  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'reservations')
  final List<String>? reservations;
  @JsonKey(name: 'schedule')
  final List<ScheduleModel>? schedule;
  @JsonKey(name: '__v')
  final int? version;


  DoctorModel({
    required this.id,
    required this.username,
    required this.email,
    required this.specialty,
    required this.gender,
    this.phone,
    this.profilePhoto,
    this.changePasswordTime,
    this.isDeleted,
    this.password,
    this.role,
    this.reservations,
    this.schedule,
    this.version,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}

@JsonSerializable()
class Reservation {
  @JsonKey(name: '_id')
  final String? id;
  final String? doctor;
  final String? user;
  final DateTime? date;
  final String? timeSlot;
  final String? status;
  @JsonKey(name: '__v')
  final int? version;

  Reservation({
     this.id,
     this.doctor,
     this.user,
     this.date,
     this.timeSlot,
     this.status,
    this.version,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}

@JsonSerializable()
class ScheduleModel {
  final DateTime? date;
  final List<String>? timeSlots;
  final String? id;

  ScheduleModel({
     this.date,
     this.timeSlots,
     this.id,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}