// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Profile_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileImageResponse _$ProfileImageResponseFromJson(
  Map<String, dynamic> json,
) => ProfileImageResponse(
  message: json['message'] as String?,
  imageUrl: json['imageUrl'] as String?,
  user:
      json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProfileImageResponseToJson(
  ProfileImageResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'imageUrl': instance.imageUrl,
  'user': instance.user,
};
