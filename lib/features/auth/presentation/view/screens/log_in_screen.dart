import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view/doctor_screen.dart';
import 'package:graduation_medical_app/features/layout/presentation/lay_out.dart';
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
  bool _isBiometricAvailable = true;

  Future<void> _authenticateWithBiometrics() async {
    bool isAvailable = await _localAuth.canCheckBiometrics;
    if (isAvailable) {
      try {
        bool isAuthenticated = await _localAuth.authenticate(
          localizedReason: 'Please authenticate to continue',
          options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
        );
        if (isAuthenticated) {
          print('Biometric authentication successful!');
          // Handle successful authentication, e.g., navigate to next screen
        } else {
          print('Biometric authentication failed');
        }
      } catch (e) {
        print('Error with biometric authentication: $e');
      }
    } else {
      print('Biometric authentication is not available');
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

  void _checkBiometricAvailability() async {
    bool isAvailable = await _localAuth.canCheckBiometrics;
    setState(() {
      _isBiometricAvailable = isAvailable;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
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
                        return SizedBox(
                          width: double.infinity,
                          child: Button(
                            text: 'Log In',
                            onClick: _logIn,
                            color: AppColors.primary,
                          ),
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
                    if (_isBiometricAvailable)
                      ElevatedButton(
                        onPressed: _authenticateWithBiometrics,
                        child: Text('Login with Biometrics'),
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
