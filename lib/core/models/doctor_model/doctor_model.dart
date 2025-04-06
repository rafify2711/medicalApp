import 'package:graduation_medical_app/features/auth/data/models/sign_in_model/login_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  @JsonKey(name: '_id')
  final String? id;

  final String? Phone;
  final String username;
  final String email;
  final String specialty;
  final Gender? gender;
  final String? profilePhoto;
  final String? Password;
  final List<String>? reservations;
  final List<ScheduleModel>? schedule;
  final String? role;
  final DateTime? changePasswordTime;
  final bool? isDeleted;
  @JsonKey(name: '__v')
  final int? v;
  DoctorModel ({this.v, this.isDeleted,this.Phone, this.Password,this.changePasswordTime,
    this.role,
    required this.id,
    required this.username,
    required this.email,
    required this.specialty,
    this.gender,
    this.profilePhoto,
    this.reservations,
    this.schedule,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}

@JsonSerializable()
class ScheduleModel {
  @JsonKey(name: '_id')
  final String? id;

  final DateTime? date;
  final List<String>? timeSlots;

  ScheduleModel({
     this.id,
     this.date,
     this.timeSlots,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}
