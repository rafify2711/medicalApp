import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository/schedule_repository.dart';
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

  class ScheduleDeleteLoading extends ScheduleState {}

  class ScheduleDeleteSuccess extends ScheduleState {
  final String message; // أو ApiMessageResponse لو أردت النوع الأصلي
  ScheduleDeleteSuccess(this.message);
  }

  class ScheduleDeleteError extends ScheduleState {
  final String message;
  ScheduleDeleteError(this.message);
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

  Future<void> deleteSchedule(DateTime date) async {
    try {
      emit(ScheduleDeleteLoading());
      final response = await _repository.deleteSchedule(date);
      emit(ScheduleDeleteSuccess(response.message??'')); // أو response.statusMessage حسب نوع الـ model
    } catch (e) {
      emit(ScheduleDeleteError(e.toString()));
    }
  }

  void reset() {
    emit(ScheduleInitial());
  }
}
