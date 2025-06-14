import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? username;
  final String? email;
  final String? password;
  final String? phone;
  final String? gender;
  final String? role;

  @JsonKey(name: 'DOB')
  final DateTime? dob;

  final DateTime? changePasswordTime;
  final bool? isDeleted;
  final String? profileImage;

  final List<String>? reservations;

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'Adress')
  final String? adress;

  final List<String>? medicationHistory;
  final List<String>? medicalHistory;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  @JsonKey(name: '__v')
  final int? v;

  UserModel({
    this.username,
    this.email,
    this.password,
    this.phone,
    this.gender,
    this.role,
    this.dob,
    this.changePasswordTime,
    this.isDeleted,
    this.profileImage,
    this.reservations,
    this.id,
    this.adress,
    this.medicationHistory,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.medicalHistory,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
