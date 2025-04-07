
import 'package:graduation_medical_app/features/edit_profile/data/models/updated_user_model.dart';
import 'package:graduation_medical_app/features/edit_profile/domain/repository/updateUser_profile_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../../user_profile/data/models/user_profile_response.dart';


@Injectable(as: UpdateUserProfileRepository)
class UpdateUserProfileRepositoryImpl  implements UpdateUserProfileRepository{
  final ApiClient _apiService;
  final SharedPrefs _sharedPrefs;


  UpdateUserProfileRepositoryImpl(this._apiService, this._sharedPrefs);

  @override
  Future<UserProfileResponse> updateUserProfile(String token,UpdateUserModel user) async {
    try {

      final storedToken = await _sharedPrefs.getToken();

      token =  storedToken ;

      if (token.isEmpty) {
        throw Exception("Missing authentication data");
      }

      final response = await _apiService.updateUserProfile("Bearer $token",user);
      return response;
    } catch (e) {
      throw Exception("Failed to fetch user profile: ${e.toString()}");
    }
  }


}
