import 'package:json_annotation/json_annotation.dart';

part 'doctors_model.g.dart';  // سيتم إنشاء هذا الملف تلقائيًا بواسطة build_runner

@JsonSerializable()
class Schedule {
  final DateTime date;
  final List<String> timeSlots;
  final String id;

  Schedule({
    required this.date,
    required this.timeSlots,
    required this.id,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

@JsonSerializable()
class Doctor {
  final String? gender;
  final bool? isDeleted;
  final String? profilePhoto;
  final List<String>? reservations;
  final String? id;
  final String name;
  final String? specialty;
  final List<Schedule>? schedule;

  Doctor({
    this.gender,
    this.isDeleted,
    this.profilePhoto,
    this.reservations,
    this.id,
    required this.name,
    this.specialty,
    this.schedule,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
