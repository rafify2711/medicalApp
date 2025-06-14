import 'package:graduation_medical_app/core/models/user_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Profile_image_response.g.dart';

@JsonSerializable()
class ProfileImageResponse {
  final String? message;
  final String? imageUrl;
  final UserModel? user;
  ProfileImageResponse({
     this.message,
     this.imageUrl,
     this.user,
  });

  factory ProfileImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageResponseFromJson(json);



}