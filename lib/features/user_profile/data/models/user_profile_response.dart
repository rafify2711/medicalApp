import 'package:graduation_medical_app/core/models/user_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  final String message;
  final UserModel user;

  UserProfileResponse({
    required this.message,
    required this.user,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
