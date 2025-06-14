import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/button.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_text_field.dart';
import 'package:graduation_medical_app/features/auth/presentation/view_model/forget_reset_password_cubit.dart';

import '../../view_model/forget_reset_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppStyle.gradient,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
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
                Navigator.pushNamed(
                  context,
                  '/reset-password',
                  arguments: _emailController.text.trim(),
                );
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
                                "Reset Your Password",
                                style: AppStyle.bodyCyanTextStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Enter your email address and we'll send you a code to reset your password",
                                style: AppStyle.bodyCyanTextStyle.copyWith(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 24),
                              MyTextField(
                                controller: _emailController,
                                label: "Email",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return "Please enter a valid email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              state is ForgotResetLoading
                                  ? const Center(child: CircularProgressIndicator())
                                  : Button(
                                      text: "Send Reset Code",
                                      onClick: () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<ForgotResetPasswordCubit>()
                                              .forgotPassword(
                                                  _emailController.text.trim());
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
      ),
    );
  }
} 