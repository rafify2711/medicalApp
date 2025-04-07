import 'package:graduation_medical_app/core/network/api_client.dart';
import 'package:graduation_medical_app/core/utils/shared_prefs.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AvailableSlotDataSource {
  final ApiClient apiManager;

  AvailableSlotDataSource({required this.apiManager});

  // تأكدنا أن الدالة ترجع List<String> بدلاً من Slot
  Future<List<String>> getAvailableSlots(DateTime date,String userId) async {
    try {

      final response = await apiManager.getAvailableSlots(userId, date);
      return List<String>.from(response);
    } catch (e) {
      throw Exception("Failed to load available slots: $e");
    }
  }
}
