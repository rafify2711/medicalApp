// تعريف حالات الـ Cubit المختلفة
abstract class AvailableSlotsState {}

class AvailableSlotsInitialState extends AvailableSlotsState {}

class AvailableSlotsLoadingState extends AvailableSlotsState {}

class AvailableSlotsLoadedState extends AvailableSlotsState {
  final List<String> availableSlots;

  AvailableSlotsLoadedState(this.availableSlots);
}

class AvailableSlotsErrorState extends AvailableSlotsState {
  final String message;

  AvailableSlotsErrorState(this.message);
}
