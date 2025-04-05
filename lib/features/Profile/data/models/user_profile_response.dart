import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  final String message;
  final User user;

  UserProfileResponse({
    required this.message,
    required this.user,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  final String id;
  final String username;
  final String email;
  final String? phone;
  final String gender;
  final bool confirmEmail;
  final String role;
  final bool isDeleted;
  final String? profilePhoto;
  final List<String>? reservations;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: "__v")
  final int v;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.phone,
    required this.gender,
    required this.confirmEmail,
    required this.role,
    required this.isDeleted,
    this.profilePhoto,
    this.reservations,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
