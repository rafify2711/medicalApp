import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/models/appointment_model/reservation_data_model.dart';

import '../../../reservation/domain/use_cases/create_reservation_usecase.dart';
import 'make_reservation_state.dart';

@injectable
class CreateReservationCubit extends Cubit<CreateReservationState> {
  final CreateReservationUsecase createReservationUsecase;

  CreateReservationCubit(this.createReservationUsecase)
      : super(CreateReservationInitial());

  Future<void> createReservation(ReservationDataModel data) async {
    emit(CreateReservationLoading());
    try {
      final response = await createReservationUsecase.call(data);
      emit(CreateReservationSuccess(response));
    } catch (e) {
      emit(CreateReservationFailure(e.toString()));
    }
  }
}
