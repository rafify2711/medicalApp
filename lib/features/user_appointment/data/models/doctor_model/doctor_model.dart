

import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/models/doctor_model/doctor_model.dart';
part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorsModel {
  @JsonKey(name: '')
  final dynamic? contact;
  final String? name;
  final List<dynamic>? careerPath;
  final List<dynamic>? highlights;
  @JsonKey(name: '_id')
  final String? id;
  final String? username;
  final String? email;
  final String? specialty;
  final String? password;
  final String? phone;
  final String? gender;
  final String? changePasswordTime;
  final bool? isDeleted;
  final String? profilePhoto;
  final List<String>? reservations;
  @JsonKey(name: 'schedule')
  final List<ScheduleModel>? schedule;
  @JsonKey(name: '__v')
  final int? v;
  final String? role;
  final String? bio;
  final int? experience;
  final String? updatedAt;

  DoctorsModel({
    this.contact,
    this.name,
    this.careerPath,
    this.highlights,
    this.id,
    this.username,
    this.email,
    this.specialty,
    this.password,
    this.phone,
    this.gender,
    this.changePasswordTime,
    this.isDeleted,
    this.profilePhoto,
    this.reservations,
    this.schedule,
    this.v,
    this.role,
    this.bio,
    this.experience,
    this.updatedAt,
  });

  factory DoctorsModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsModelToJson(this);
}