import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/splash/welcome_screen.dart';
import 'package:graduation_medical_app/core/di/di.dart';
import 'package:graduation_medical_app/features/auth/data/data_source/auth_local_data_source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final authLocalDataSource = getIt<AuthLocalDataSource>();
    final token = authLocalDataSource.getToken();
    final role = authLocalDataSource.getUserRole();

    if (token.isNotEmpty && role.isNotEmpty) {
      // User is logged in, navigate based on role
      if (role == 'User') {
        Navigator.pushReplacementNamed(context, RouteNames.userLayout);
      } else if (role == 'Doctor') {
        Navigator.pushReplacementNamed(context, RouteNames.doctorLayout);
      } else {
        // Invalid role, go to welcome screen
        Navigator.pushReplacementNamed(context, RouteNames.welcome);
      }
    } else {
      // No token or role, go to welcome screen
      Navigator.pushReplacementNamed(context, RouteNames.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppStyle.gradient),
        child: Center(
          child: Image.asset(
            'lib/assets/icon/Vector.png',
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
