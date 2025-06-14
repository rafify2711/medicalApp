import 'dart:io';

import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/shared_prefs.dart';
import '../../domain/repository/user_profile_repository.dart';


import '../models/Profile_image_response.dart';
import '../models/user_profile_response.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final ApiClient _apiService;
  final SharedPrefs _sharedPrefs;

  UserRepositoryImpl(this._apiService, this._sharedPrefs);

  @override
  Future<UserProfileResponse> getUserProfile(String token, String userId) async {
    try {

      final storedToken = await _sharedPrefs.getToken();
      final storedUserId =await _sharedPrefs.getUserId();

      token = token.isNotEmpty ? token : (storedToken ?? "");
      userId = userId.isNotEmpty ? userId : (storedUserId ?? "");

      if (token.isEmpty || userId.isEmpty) {
        throw Exception("Missing authentication data");
      }

      final response = await _apiService.getUserProfile("Bearer $token", userId);
      return response;
    } catch (e) {
      throw Exception("Failed to fetch user profile: ${e.toString()}");
    }
  }
  @override
  Future<void> logout() async {
    try {


      // مسح البيانات المخزنة في SharedPrefs مثل التوكن ومعرف المستخدم
      await _sharedPrefs.logout();
      print("token:${_sharedPrefs.getToken()}");
      print("user logged out");



    } catch (e) {
      throw Exception("Failed to logout: ${e.toString()}");
    }
  }

  @override
  Future<ProfileImageResponse> updateProfileImage(File? imagePath) async{
    try{
      final storedToken= await _sharedPrefs.getToken();
    return _apiService.updateProfileImage("Bearer $storedToken", imagePath);

  }catch(e){
      throw Exception("Failed to update profile image: ${e.toString()}");
    }}
}


