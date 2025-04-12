import '../../../../core/models/doctor_model/doctor_model.dart';
import '../../data/models/add_update_schedule_response.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleSuccess extends ScheduleState {
  final AddUpdateScheduleResponse schedules;

  ScheduleSuccess(this.schedules);
}

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError(this.message);
}
