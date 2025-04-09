import '../../../../core/models/doctor_model/doctor_model.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleSuccess extends ScheduleState {
  final List<ScheduleModel> schedules;

  ScheduleSuccess(this.schedules);
}

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError(this.message);
}
