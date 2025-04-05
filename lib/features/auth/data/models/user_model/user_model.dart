import 'package:json_annotation/json_annotation.dart';

import '../sign_in_model/login_response.dart';


abstract class UserModel {



  final String username;
  final String email;
  @JsonKey(name: 'password')
  final String hashedPassword;
  final String? phone; // Encrypted value
  final Gender? gender;
  @JsonKey(name: 'confirmEmail')
  final bool? isEmailConfirmed;
  final String? role;
  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;
  final String? profilePhoto;
  @JsonKey(name: '_id')
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  UserModel({
    required this.username,
    required this.email,
    required this.hashedPassword,
     this.phone,
    this.gender,
     this.isEmailConfirmed,
    this.role,
     this.isDeleted,
     this.profilePhoto,
     this.id,
     this.createdAt,
    this.updatedAt,
    this.version,
  });

}
