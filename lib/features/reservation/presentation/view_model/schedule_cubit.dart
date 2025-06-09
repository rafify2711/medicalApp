import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/schedule_repository.dart';
import '../../data/repositories/schedule_repository_impl.dart';
import '../../data/models/schedule_model.dart';


// States
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleSuccess extends ScheduleState {
  final List<ScheduleModel> schedule;
  ScheduleSuccess(this.schedule);
}

class ScheduleError extends ScheduleState {
  final String message;
  ScheduleError(this.message);
}

// Cubit
@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepository _repository;

  ScheduleCubit(this._repository) : super(ScheduleInitial());

  Future<void> fetchSchedule(String doctorId, String token) async {
    try {
      emit(ScheduleLoading());
      final schedule = await _repository.fetchSchedule();
      emit(ScheduleSuccess(schedule));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  void reset() {
    emit(ScheduleInitial());
  }
} 