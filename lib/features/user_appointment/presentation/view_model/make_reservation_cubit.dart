import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/appointment_model/reservation_data_model.dart';
import '../../../reservation/domain/use_cases/create_reservation_usecase.dart';
import 'make_reservation_state.dart';


@lazySingleton
class CreateReservationCubit extends Cubit<CreateReservationState> {
  final CreateReservationUsecase usecase;
  bool _isLoading = false;
  bool _isClosed = false;

  CreateReservationCubit(this.usecase) : super(CreateReservationInitial());

  Future<void> createReservation(ReservationDataModel data) async {
    if (_isLoading || _isClosed) return;
    
    try {
      _isLoading = true;
      if (!_isClosed) emit(CreateReservationLoading());
      
      final response = await usecase(data);
      if (!_isClosed) emit(CreateReservationSuccess(response));
    } catch (e) {
      if (!_isClosed) emit(CreateReservationError(e.toString()));
    } finally {
      _isLoading = false;
    }
  }

  @override
  Future<void> close() async {
    _isClosed = true;
    _isLoading = false;
    return super.close();
  }
}


