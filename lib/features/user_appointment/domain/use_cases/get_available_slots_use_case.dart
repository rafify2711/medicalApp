import 'package:injectable/injectable.dart';
import '../repository/available_slot_repository.dart';

@injectable
class GetAvailableSlotsUseCase {
  final AvailableSlotsRepository availableSlotsRepository;

  GetAvailableSlotsUseCase(this.availableSlotsRepository);

  Future<List<String>> execute(DateTime date, String userId) {
    return availableSlotsRepository.getAvailableSlots(date, userId);
  }
}

