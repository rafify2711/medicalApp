import 'package:json_annotation/json_annotation.dart';

part 'signup_doctor_model.g.dart';

@JsonSerializable()
class SignupDoctorModel {
  final String username;
  final String email;
  final String password;
  final String confirmationPassword;
  final String role;
  final String specialty;

  SignupDoctorModel({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmationPassword,
    required this.role,
    required this.specialty,
  });

  factory SignupDoctorModel.fromJson(Map<String, dynamic> json) => _$SignupDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupDoctorModelToJson(this);
}
