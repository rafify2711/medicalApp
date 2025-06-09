import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:injectable/injectable.dart';
import '../models/schedule_model.dart';
import '../models/schedule_response.dart';


abstract class ScheduleRepository {

  Future<List<ScheduleModel>> fetchSchedule();

} 