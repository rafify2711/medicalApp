import 'package:graduation_medical_app/features/auth/data/models/user_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../sign_in_model/login_response.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel extends UserModel {
  PatientModel({
    required super.username,
    required super.email,
    required super.hashedPassword,
    required super.phone,
    required super.gender,
    required super.isEmailConfirmed,
    required super.role,
    required super.isDeleted,
    required super.profilePhoto,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => _$PatientModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}
