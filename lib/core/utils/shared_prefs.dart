import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefs {
  final SharedPreferences _prefs;

  SharedPrefs(this._prefs); // ✅ تمرير SharedPreferences عند الإنشاء

  String getUserId() {
    return _prefs.getString('userId') ?? "";
  }

  String getToken() {
    return _prefs.getString('token') ?? "";
  }

  Future<void> logout() async {
    await _prefs.clear();
  }

  Future<void> saveUserData(String? token, String userId) async {
    await _prefs.setString('token', token ?? '');
    await _prefs.setString('userId', userId);
  }
}

