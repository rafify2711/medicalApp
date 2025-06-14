import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view_model/user_appointment_state.dart';
import 'package:injectable/injectable.dart';

import '../../../reservation/domain/use_cases/cancel_reservation_use_case.dart';
import '../../domain/use_cases/get_user_appointment_use_case.dart';

@injectable
class UserAppointmentCubit extends Cubit<UserAppointmentState> {
  final GetUserAppointmentsUseCase getUserAppointmentsUseCase;
  final CancelReservationUseCase cancelReservationUseCase;

  UserAppointmentCubit(
      this.getUserAppointmentsUseCase,
      this.cancelReservationUseCase,
      ) : super(AppointmentInitial());

  void fetchAppointments(String userId, String token) async {
    emit(AppointmentLoading());
    try {
      final appointments = await getUserAppointmentsUseCase(userId, token);
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError("Error loading appointments"));
    }
  }

  Future<void> cancelReservation(String reservationId) async {
    emit(CancelReservationLoading());
    try {
      final response = await cancelReservationUseCase(reservationId);
      emit(CancelReservationSuccess(response.message!)); // أو .statusMessage حسب الموديل
    } catch (e) {
      emit(CancelReservationError("Failed to cancel reservation"));
    }
  }
}
