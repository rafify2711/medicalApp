
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_data.g.dart';
@JsonSerializable()
class ResetPasswordData {
  final String email;
  final String otp;
  final String newPassword;

  ResetPasswordData({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  factory ResetPasswordData.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordDataToJson(this);
}
