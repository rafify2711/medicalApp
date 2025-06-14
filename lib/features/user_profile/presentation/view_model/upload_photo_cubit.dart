import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/user_profile/presentation/view_model/upload_photo_state.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/user/upload_profile_phot_use_case.dart';

@injectable
class UploadProfilePhotoCubit extends Cubit<UploadProfilePhotoState> {
  final UploadProfilePhotoUseCase uploadProfilePhotoUseCase;

  UploadProfilePhotoCubit(this.uploadProfilePhotoUseCase)
      : super(UploadProfilePhotoInitial());

  Future<void> uploadProfilePhoto(File imageFile) async {
    emit(UploadProfilePhotoLoading());
    try {
      final result = await uploadProfilePhotoUseCase.read(imageFile);
      emit(UploadProfilePhotoSuccess(result));
    } catch (e) {
      emit(UploadProfilePhotoError("Failed to upload profile image: ${e.toString()}"));
    }
  }
}
