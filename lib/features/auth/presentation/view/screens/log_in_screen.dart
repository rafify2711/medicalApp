import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';

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
  final TextEditingController _emailController = TextEditingController(text:'ranimafify@gmail.com');
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

  void _login() {
    if (_formKey.currentState!.validate()) {
      final signInModel = SignInModel(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      context.read<AuthCubit>().logIn(signInModel);
    }
  }

  void _loginWithBiometrics() {
    context.read<AuthCubit>().loginWithBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: AppLocalizations.of(context).login),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).welcomeBack,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context).loginToContinue,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    AppLocalizations.of(context).email,
                    style: AppStyle.bodyBlackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  MyTextField(
                    controller: _emailController,
                    label: 'example@example.com',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).pleaseEnterEmail;
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return AppLocalizations.of(context).invalidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context).password,
                    style: AppStyle.bodyBlackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
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
                        return AppLocalizations.of(context).pleaseEnterPassword;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password
                      },
                      child: Text(AppLocalizations.of(context).forgotPassword),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoginSuccess) {
                        final role = state.role;
                        log('roleeeee ${state.role}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context).success)),
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
                              text: AppLocalizations.of(context).login,
                              onClick: _login,
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
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context).dontHaveAccount,
                          style: AppStyle.bodyBlackTextStyle.copyWith(
                            fontSize: 14,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          child: Text(
                            AppLocalizations.of(context).signup,
                            style: AppStyle.bodyCyanTextStyle.copyWith(
                              fontSize: 14,
                              color: AppColors.primary1,
                              fontWeight: FontWeight.w500,
                            ),
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
          ),
        ),
      ),
    );
  }
}
