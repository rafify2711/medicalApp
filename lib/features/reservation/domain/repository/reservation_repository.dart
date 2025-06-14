import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/reservation/data/models/add_update_schedule_response.dart';

import '../../../../core/models/api_message_response.dart';
import '../../../../core/models/appointment_model/reservation_data_model.dart';
import '../../data/models/create_reservation_response.dart';

abstract class ReservationRepository {
  Future<AddUpdateScheduleResponse> addUpdateSchedule( String doctorId,String token,AddUpdateScheduleData schedule);
  Future<CreateReservationResponse> createReservation(ReservationDataModel data);
  Future<ApiMessageResponse> cancelReservation(String reservationId);
}