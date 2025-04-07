abstract class AvailableSlotsRepository {
  Future<List<String>> getAvailableSlots(DateTime date,String userId);
}