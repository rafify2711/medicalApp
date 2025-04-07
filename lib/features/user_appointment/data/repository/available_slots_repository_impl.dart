
import 'package:injectable/injectable.dart';

import '../../domain/repository/available_slot_repository.dart';
import '../data_source/available_slot_data_source/available_slot_data_source.dart';

@Singleton(as: AvailableSlotsRepository)
class AvailableSlotsRepositoryImpl implements AvailableSlotsRepository {
  final AvailableSlotDataSource availableSlotDataSourceDataSource;

  AvailableSlotsRepositoryImpl(this.availableSlotDataSourceDataSource);

  @override
  Future<List<String>> getAvailableSlots(DateTime date,String userId) {
    return availableSlotDataSourceDataSource.getAvailableSlots( date,userId);
  }
}
