import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/shared_prefs.dart';

abstract class AuthLocalDataSource {
  Future<bool> cacheUserData(String? token, String userId);
  String getToken();
  String getUserId();
  Future<void> logout();
}


@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPrefs sharedPrefs;

  AuthLocalDataSourceImpl(this.sharedPrefs);


  Future<bool> cacheUserData(String? token, String userId) async {
    debugPrint('Saving token: $token, userId: $userId');
    await sharedPrefs.saveUserData(token, userId);

    // تأكيد الحفظ بإرجاع true
    return true;
  }




  String? _token;

  void saveToken(String token) {
  _token = token;
  }



  @override
  String getToken() => sharedPrefs.getToken();

  @override
  String getUserId() => sharedPrefs.getUserId();

  @override
  Future<void> logout() async {
    await sharedPrefs.logout();
  }
}
