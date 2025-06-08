import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../data/models/update_doctor_model.dart';
import '../../domain/repository/doctor_profile_repository.dart';

part 'doctor_profile_state.dart';

@injectable
class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepository _doctorRepository;
  final SharedPrefs _sharedPrefs;

  DoctorProfileCubit(this._doctorRepository, this._sharedPrefs) : super(DoctorProfileInitial());

  Future<void> fetchDoctorProfile(String userId) async {
    emit(DoctorProfileLoading());
    try {
      final profile = await _doctorRepository.getDoctorProfile(userId);
      emit(DoctorProfileLoaded(profile));
    } catch (e) {
      emit(DoctorProfileError(e.toString()));
      print(e.toString());
    }
  }

  Future<void> updateProfile(String userId, UpdateDoctorModel model) async {
    emit(DoctorProfileLoading());
    try {
      final token = await _sharedPrefs.getToken();
      if (token == null) {
        throw Exception("No authentication token found");
      }

      final updatedProfile = await _doctorRepository.updateDoctorProfile(userId, token, model);
      emit(DoctorProfileLoaded(updatedProfile));
    } catch (e) {
      emit(DoctorProfileError(e.toString()));
      print(e.toString());
    }
  }
}
