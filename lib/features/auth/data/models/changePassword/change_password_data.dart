import 'package:json_annotation/json_annotation.dart';

part 'change_password_data.g.dart';
@JsonSerializable()
class ChangePasswordData {
  final String oldPassword ;
  final String newPassword ;
  final String confirmPassword ;
  ChangePasswordData({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
  factory ChangePasswordData.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordDataFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordDataToJson(this);


}