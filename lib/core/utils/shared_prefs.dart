import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefs {
  final SharedPreferences _prefs;

  SharedPrefs(this._prefs); // ✅ Passing SharedPreferences during construction

  String getUserId() {
    return _prefs.getString('userId') ?? "";
  }

  String getToken() {
    return _prefs.getString('token') ?? "";
  }

  String getRole() {
    return _prefs.getString('role') ?? "";
  }

  Future<void> logout() async {
    await _prefs.clear();
  }

  Future<void> saveUserData(String? token, String userId, String role) async {
    await _prefs.setString('token', token ?? '');
    await _prefs.setString('userId', userId);
    await _prefs.setString('role', role);
  }

  // New Methods for Biometric Status

  Future<void> saveBiometricStatus(bool isAuthenticated) async {
    await _prefs.setBool('biometricAuthenticated', isAuthenticated);
  }

  Future<bool> getBiometricStatus() async {
    return _prefs.getBool('biometricAuthenticated') ?? false; // Default to false
  }
}
