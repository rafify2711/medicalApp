import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/doctor_model/doctor_model.dart';
import '../../data/models/add_update_schedule_response.dart';
import '../../domain/use_cases/add_update_schedule_use_case.dart';
import 'add_update_schedule_state.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  final AddUpdateScheduleUseCase addUpdateScheduleUseCase;

  ScheduleCubit(this.addUpdateScheduleUseCase) : super(ScheduleInitial());

  Future<void> addUpdateSchedule(String token, String userId ,AddUpdateScheduleData schedule) async {
    emit(ScheduleLoading());
    try {

      final schedules = await addUpdateScheduleUseCase(token, userId,schedule);

      emit(ScheduleSuccess(schedules));
    } catch (e) {
      emit(ScheduleError(e.toString()));
      print(e.toString());
    }
  }
}
