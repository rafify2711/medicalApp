// features/user_profile/presentation/cubit/upload_profile_photo_state.dart
import 'package:graduation_medical_app/features/user_profile/data/models/Profile_image_response.dart';

abstract class UploadProfilePhotoState {}

class UploadProfilePhotoInitial extends UploadProfilePhotoState {}

class UploadProfilePhotoLoading extends UploadProfilePhotoState {}

class UploadProfilePhotoSuccess extends UploadProfilePhotoState {
  final ProfileImageResponse response;

  UploadProfilePhotoSuccess(this.response);
}

class UploadProfilePhotoError extends UploadProfilePhotoState {
  final String message;

  UploadProfilePhotoError(this.message);
}
