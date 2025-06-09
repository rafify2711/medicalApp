import 'package:graduation_medical_app/core/models/user_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_response.g.dart';
@JsonSerializable()
class ChangePasswordResponse {
  final String? message;
 final UserModel? user;
  ChangePasswordResponse({this.message, this.user});

  factory  ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);





}