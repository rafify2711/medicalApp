

import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/models/doctor_model/doctor_model.dart';
part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorsModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? username;
  final String? email;
  final String? specialty;
  final String? gender;
  final String? phone;
  final String? profilePhoto;
  final DateTime? changePasswordTime;
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


  DoctorsModel({
    this.id,
    this.username,
    this.email,
    this.specialty,
    this.gender,
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

  factory DoctorsModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsModelToJson(this);
}