import 'package:graduation_medical_app/features/auth/data/models/user_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../sign_in_model/login_response.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel extends UserModel {
  @JsonKey(name: "specialty") // ✅ تصحيح التهجئة لتتوافق مع JSON
  final String specialty;

  final List<String>? schedule;

  @JsonKey(name: "_id") // ✅ التأكد من جلب الـ id بشكل صحيح
  final String? id;

  DoctorModel({
    required super.username,
    required super.email,
    required super.hashedPassword,
    super.gender,
    super.role,
    super.isDeleted,
    super.profilePhoto,
    this.id,
    required this.specialty,
    this.schedule,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}
