import 'package:json_annotation/json_annotation.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';

part 'update_doctor_model.g.dart';

@JsonSerializable()
class UpdateDoctorModel {
  final String? name;
  final String? phone;
  final String? bio;
  final int? experience;
  final List<String>? careerPath;
  final List<String>? highlights;
  final ContactModel? contact;
  final String? gender;

  UpdateDoctorModel({
    this.name,
    this.phone,
    this.bio,
    this.experience,
    this.careerPath,
    this.highlights,
    this.contact,
    this.gender,
  });

  factory UpdateDoctorModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDoctorModelToJson(this);
} 