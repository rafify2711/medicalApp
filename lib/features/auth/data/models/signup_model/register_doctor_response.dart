
import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/models/doctor_model/doctor_model.dart';


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

