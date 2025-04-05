// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    UserProfileResponse(
      message: json['message'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileResponseToJson(
  UserProfileResponse instance,
) => <String, dynamic>{'message': instance.message, 'user': instance.user};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['_id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  gender: json['gender'] as String,
  confirmEmail: json['confirmEmail'] as bool,
  role: json['role'] as String,
  isDeleted: json['isDeleted'] as bool,
  profilePhoto: json['profilePhoto'] as String?,
  reservations:
      (json['reservations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  v: (json['__v'] as num).toInt(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  '_id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'phone': instance.phone,
  'gender': instance.gender,
  'confirmEmail': instance.confirmEmail,
  'role': instance.role,
  'isDeleted': instance.isDeleted,
  'profilePhoto': instance.profilePhoto,
  'reservations': instance.reservations,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  '__v': instance.v,
};
