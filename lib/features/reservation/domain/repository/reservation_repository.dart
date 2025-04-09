import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/reservation/data/models/add_update_schedule_response.dart';

abstract class ReservationRepository {
  Future<List<ScheduleModel>> addUpdateSchedule( String doctorId,String token,AddUpdateScheduleData schedule);

}