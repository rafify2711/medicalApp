
import 'package:graduation_medical_app/features/reservation/domain/repository/reservation_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/appointment_model/reservation_data_model.dart';

import '../../data/models/create_reservation_response.dart';

@lazySingleton
class CreateReservationUsecase {
  final ReservationRepository repository;

  CreateReservationUsecase(this.repository);

  Future<CreateReservationResponse> call(ReservationDataModel data) {
    return repository.createReservation(data);
  }
}
