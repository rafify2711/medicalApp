import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view/doctor_screen.dart';
import 'package:graduation_medical_app/features/layout/presentation/lay_out.dart';

import '../../../../../core/config/route_names.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../layout/presentation/doctor_lay_out.dart';
import '../../../data/models/sign_in_model/sign_in_model.dart';
import '../../view_model/auth_cubit.dart';

import '../widgets/my_app_par.dart';
import '../widgets/my_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});


  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _logIn() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final signInModel = SignInModel(email: email, password: password);
      context.read<AuthCubit>().logIn(signInModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: "Log In"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Email Field
                    Text(
                      'Email',
                      style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16),
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
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
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
                    const SizedBox(height: 24),
                    // Log-In Button with BlocConsumer
                    BlocConsumer<AuthCubit, AuthState>(
                       listener: (context, state) {
              if (state is AuthLoginSuccess) {
              final role = state.role;
              print(role);
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Successful!")),
              );
              if (role == 'User') {
              Navigator.pushReplacementNamed(context, RouteNames.userLayout);
              } else if (role == 'Doctor'){
              Navigator.pushReplacementNamed(context,  RouteNames.doctorLayout);
              }
              } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
              );
              }
              },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _logIn, // Fixed function call
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Log In',
                              style: AppStyle.bodyWhiteTextStyle,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Redirect to Sign Up
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, RouteNames.signUp);
                        },
                        child: Text(
                          "Don't have an account? Sign up",
                          style: AppStyle.bodyCyanTextStyle.copyWith(fontSize: 15),
                        ),
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
