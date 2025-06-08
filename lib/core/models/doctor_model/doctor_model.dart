import 'package:graduation_medical_app/features/reservation/data/models/create_reservation_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  @JsonKey(name: 'contact')
  final ContactModel? contact;
  final String? name;
  final List<String>? careerPath;
  final List<String>? highlights;
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

  DoctorModel({
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

@JsonSerializable()
class ContactModel {
  final String? facebook;
  final String? linkedin;
  final String? twitter;
  final String? website;
  final String? whatsapp;
  final String? phone;

  ContactModel({
    this.facebook,
    this.linkedin,
    this.twitter,
    this.website,
    this.whatsapp,
    this.phone,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
