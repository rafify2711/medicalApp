import 'package:graduation_medical_app/features/auth/data/models/user_model/patient_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user_model/doctor_model.dart';

part 'register_doctor_response.g.dart';


@JsonSerializable()
class RegisterDoctorResponse {
  String message;
  DoctorModel user;

  RegisterDoctorResponse(this.message,
      this.user,);

  factory RegisterDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterDoctorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDoctorResponseToJson(this);
}

