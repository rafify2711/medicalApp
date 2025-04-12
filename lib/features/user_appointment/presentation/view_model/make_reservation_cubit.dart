import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/appointment_model/reservation_data_model.dart';
import '../../../reservation/domain/use_cases/create_reservation_usecase.dart';
import 'make_reservation_state.dart';


@lazySingleton
class CreateReservationCubit extends Cubit<CreateReservationState> {
  final CreateReservationUsecase usecase;

  CreateReservationCubit(this.usecase) : super(CreateReservationInitial());

  Future<void> createReservation(ReservationDataModel data) async {
    emit(CreateReservationLoading());
    try {
      final response = await usecase(data);
      emit(CreateReservationSuccess(response));
    } catch (e) {
      emit(CreateReservationError(e.toString()));
    }
  }

  void resetState() {
    emit(CreateReservationInitial());
  }
}
