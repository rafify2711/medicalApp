import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/models/api_message_response.dart';
import '../../data/models/schedule_model.dart';
import '../../data/models/schedule_response.dart';


abstract class ScheduleRepository {

  Future<List<ScheduleModel>> fetchSchedule();
  Future<ApiMessageResponse> deleteSchedule(DateTime  date);


} 