import 'package:graduation_medical_app/features/auth/data/models/user_model/patient_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_user_response.g.dart';


@JsonSerializable()
class RegisterUserResponse {
  String message;
  PatientModel user;

  RegisterUserResponse(this.message,
      this.user,);

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserResponseToJson(this);
}

