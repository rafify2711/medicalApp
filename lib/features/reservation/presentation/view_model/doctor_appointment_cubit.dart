import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/models/doctor_appointment_model.dart';
import '../../data/repositories/doctor_appointment_repository_impl.dart';
import '../../data/models/doctor_appointment_model.dart';

// States
abstract class DoctorAppointmentState {}

class DoctorAppointmentInitial extends DoctorAppointmentState {}

class DoctorAppointmentLoading extends DoctorAppointmentState {}

class DoctorAppointmentSuccess extends DoctorAppointmentState {
  final List<Reservation>? appointments;
  DoctorAppointmentSuccess(this.appointments);
}

class DoctorAppointmentError extends DoctorAppointmentState {
  final String message;
  DoctorAppointmentError(this.message);
}

// Cubit
@injectable
class DoctorAppointmentCubit extends Cubit<DoctorAppointmentState> {
  final DoctorAppointmentRepository _repository;

  DoctorAppointmentCubit(this._repository) : super(DoctorAppointmentInitial());

  Future<void> fetchDoctorAppointments() async {
    try {
      emit(DoctorAppointmentLoading());
      final appointments = await _repository.fetchDoctorAppointments();
      emit(DoctorAppointmentSuccess(appointments.reservations));
    } catch (e) {
      emit(DoctorAppointmentError(e.toString()));
    }
  }

  void reset() {
    emit(DoctorAppointmentInitial());
  }
} 