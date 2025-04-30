import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../core/utils/shared_prefs.dart';

abstract class AuthLocalDataSource {
  Future<bool> cacheUserData(String? token, String userId,String role);
  String getToken();
  String getUserId();
  Future<void> logout();
  String getUserRole();
// New methods for biometric
  Future<bool> authenticateWithBiometrics();
  Future<void> storeBiometricStatus(bool isAuthenticated);
  Future<bool> getBiometricStatus();
}


@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPrefs sharedPrefs;
  final LocalAuthentication _localAuth = LocalAuthentication();

  AuthLocalDataSourceImpl(this.sharedPrefs);

  @override
  Future<bool> cacheUserData(String? token, String userId, String role) async {
    await sharedPrefs.saveUserData(token, userId, role);
    print('***************Saving token: $token, userId: $userId, role: $role');
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

  // Biometric Methods
  @override
  Future<bool> authenticateWithBiometrics() async {
    try {
      bool isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        return false; // Biometrics not available on the device
      }

      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access your account',
        options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
      );
      return isAuthenticated;
    } catch (e) {
      print('Error during biometric authentication: $e');
      return false;
    }
  }

  @override
  Future<void> storeBiometricStatus(bool isAuthenticated) async {
    await sharedPrefs.saveBiometricStatus(isAuthenticated);
  }

  @override
  Future<bool> getBiometricStatus() async {
    return await sharedPrefs.getBiometricStatus();
  }
}

