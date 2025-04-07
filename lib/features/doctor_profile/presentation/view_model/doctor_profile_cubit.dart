import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/doctor_profile_repository.dart';


part 'doctor_profile_state.dart';
@injectable
class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepository _doctorRepository;

  DoctorProfileCubit(this._doctorRepository) : super(DoctorProfileInitial());

  Future<void> fetchDoctorProfile( String userId) async {
    emit(DoctorProfileLoading());
    try {
      final profile = await _doctorRepository.getDoctorProfile( userId);
      emit(DoctorProfileLoaded(profile));
    } catch (e) {
      emit(DoctorProfileError(e.toString()));
      print(e.toString());
    }
  }
}
