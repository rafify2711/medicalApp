import 'package:injectable/injectable.dart';

import '../../../../core/models/api_message_response.dart';
import '../repository/reservation_repository.dart';

@injectable
class CancelReservationUseCase {
  final ReservationRepository repository;

  CancelReservationUseCase(this.repository);

  Future<ApiMessageResponse> call(String reservationId) {
    return repository.cancelReservation(reservationId);
  }
}
