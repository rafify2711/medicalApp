import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../core/config/route_names.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../layout/presentation/doctor_lay_out.dart';
import '../../../data/models/sign_in_model/sign_in_model.dart';
import '../../view_model/auth_cubit.dart';

import '../widgets/button.dart';
import '../widgets/my_app_par.dart';
import '../widgets/my_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(text: 'rafify27@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '123456789Rr#');
  bool _obscurePassword = true;
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      setState(() {
        _isBiometricAvailable = isAvailable && isDeviceSupported;
      });
    } catch (e) {
      print('Error checking biometric availability: $e');
      setState(() {
        _isBiometricAvailable = false;
      });
    }
  }

  void _logIn() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final signInModel = SignInModel(email: email, password: password);
      context.read<AuthCubit>().logIn(signInModel);
    }
  }

  void _loginWithBiometrics() {
    context.read<AuthCubit>().loginWithBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: "Log In"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text('Welcome', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.primary1)),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Email Field
                    Text(
                      'Email',
                      style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    MyTextField(
                      controller: _emailController,
                      label: 'example@example.com',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    Text(
                      'Password',
                      style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16),
                    ),
                    MyTextField(
                      controller: _passwordController,
                      label: '**********',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.primary1,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          'Forget Password?',
                          style: AppStyle.bodyCyanTextStyle.copyWith(fontSize: 12, color: AppColors.primary1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Log-In Button with BlocConsumer
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoginSuccess) {
                          final role = state.role;
                          log('roleeeee ${state.role}');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login Successful!")),
                          );
                          if (role == 'User') {
                            Navigator.pushReplacementNamed(context, RouteNames.userLayout);
                          } else if (role == 'Doctor') {
                            Navigator.pushReplacementNamed(context, RouteNames.doctorLayout);
                          }
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(child: CircularProgressIndicator(color: AppColors.primary1));
                        }
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Button(
                                text: 'Log In',
                                onClick: _logIn,
                                color: AppColors.primary,
                              ),
                            ),
                            if (_isBiometricAvailable) ...[
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _loginWithBiometrics,
                                  icon: Icon(Icons.fingerprint, color: AppColors.primary1),
                                  label: Text(
                                    'Login with Biometrics',
                                    style: TextStyle(color: AppColors.primary1),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(color: AppColors.primary1),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Redirect to Sign Up
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 14, color: AppColors.black, fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                            child: Text(
                              "Sign up",
                              style: AppStyle.bodyCyanTextStyle.copyWith(fontSize: 14, color: AppColors.primary1, fontWeight: FontWeight.w500),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, RouteNames.signUp);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
