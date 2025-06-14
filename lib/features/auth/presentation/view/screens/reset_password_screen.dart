import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/button.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_text_field.dart';
import 'package:graduation_medical_app/features/auth/presentation/view_model/forget_reset_password_cubit.dart';
import '../../../../../core/config/route_names.dart';
import '../../view_model/forget_reset_password_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  Timer? _timer;
  int _remainingSeconds = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _remainingSeconds = 30;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendCode() {
    if (_canResend) {
      context.read<ForgotResetPasswordCubit>().forgotPassword(widget.email).then((_) {
        _startTimer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppStyle.gradient,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: BlocConsumer<ForgotResetPasswordCubit, ForgotResetPasswordState>(
          listener: (context, state) {
            if (state is ForgotResetSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              if (state.message.contains("OTP sent to email")) {
                _startTimer();
              } else if (state.message.contains("Password reset successful")) {
                Navigator.pushReplacementNamed(context, RouteNames.login);
              }
            } else if (state is ForgotResetFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Reset Code",
                              style: AppStyle.bodyCyanTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Enter the code sent to ${widget.email}",
                              style: AppStyle.bodyCyanTextStyle.copyWith(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 24),
                            MyTextField(
                              controller: _otpController,
                              label: "Reset Code",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter the reset code";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            MyTextField(
                              controller: _newPasswordController,
                              label: "New Password",
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
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
                                  return "Please enter a new password";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            MyTextField(
                              controller: _confirmPasswordController,
                              label: "Confirm New Password",
                              obscureText: _obscureConfirmPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.primary1,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your new password";
                                }
                                if (value != _newPasswordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn't receive the code? ",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                TextButton(
                                  onPressed: _canResend ? _resendCode : null,
                                  child: Text(
                                    _canResend
                                        ? "Resend Code"
                                        : "Resend in $_remainingSeconds s",
                                    style: TextStyle(
                                      color: _canResend
                                          ? AppColors.primary1
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            state is ForgotResetLoading
                                ? const Center(child: CircularProgressIndicator())
                                : Button(
                              text: "Reset Password",
                              onClick: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<ForgotResetPasswordCubit>()
                                      .resetPassword(
                                    widget.email,
                                    _otpController.text.trim(),
                                    _newPasswordController.text.trim(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}