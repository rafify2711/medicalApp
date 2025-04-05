import 'package:json_annotation/json_annotation.dart';

part 'signup_user_model.g.dart';

@JsonSerializable()
class SignupUserModel {
  final String username;
  final String email;
  final String password;
  final String confirmationPassword;
  final String role;

  SignupUserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmationPassword,
    required this.role,
  });

  factory SignupUserModel.fromJson(Map<String, dynamic> json) => _$SignupUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupUserModelToJson(this);
}
