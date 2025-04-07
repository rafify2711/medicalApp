import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/get_available_slots_use_case.dart';
import 'available_slots_state.dart'; // تعريف حالات الـ Cubit

@injectable
class AvailableSlotsCubit extends Cubit<AvailableSlotsState> {
  final GetAvailableSlotsUseCase getAvailableSlotsUseCase;

  AvailableSlotsCubit(this.getAvailableSlotsUseCase)
      : super(AvailableSlotsInitialState());

  Future<void> loadAvailableSlots(DateTime date, String userId) async {
    try {
      emit(AvailableSlotsLoadingState()); // تغيير الحالة إلى Loading أثناء تحميل البيانات
      final slots = await getAvailableSlotsUseCase.execute(date, userId);
      emit(AvailableSlotsLoadedState(slots)); // حالة تم تحميل المواعيد بنجاح
    } catch (e) {
      emit(AvailableSlotsErrorState("Failed to load available slots"));
    }
  }
}
