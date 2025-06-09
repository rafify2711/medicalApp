import 'package:json_annotation/json_annotation.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';

part 'update_doctor_response.g.dart';

@JsonSerializable()
class UpdateDoctorResponse {
  final String message;
  final DoctorModel updatedDoctor;

  UpdateDoctorResponse({
    required this.message,
    required this.updatedDoctor,
  });

  factory UpdateDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateDoctorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDoctorResponseToJson(this);
} 