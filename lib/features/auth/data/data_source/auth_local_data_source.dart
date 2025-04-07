import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/shared_prefs.dart';

abstract class AuthLocalDataSource {
  Future<bool> cacheUserData(String? token, String userId,String role);
  String getToken();
  String getUserId();
  Future<void> logout();
  String getUserRole();

}


@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPrefs sharedPrefs;

  AuthLocalDataSourceImpl(this.sharedPrefs);


  Future<bool> cacheUserData(String? token, String userId, String role) async {

    await sharedPrefs.saveUserData(token, userId, role);
    print('***************Saving token: $token, userId: $userId, role: $role');
    // تأكيد الحفظ بإرجاع true
    return true;
  }


  @override
  String getToken() => sharedPrefs.getToken();

  @override
  String getUserId() => sharedPrefs.getUserId();

  @override
  String getUserRole() => sharedPrefs.getRole();


  @override
  Future<void> logout() async {
    await sharedPrefs.logout();
  }
}


