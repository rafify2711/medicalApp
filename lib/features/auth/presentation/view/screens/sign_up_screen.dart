import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/screens/log_in_screen.dart';
import 'package:graduation_medical_app/features/doctor_home/presentation/doctor_home_screen.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../data/models/signup_model/signup_doctor_model.dart';
import '../../../data/models/signup_model/signup_user_model.dart';
import '../../view_model/auth_cubit.dart';
import '../widgets/my_app_par.dart';
import '../widgets/my_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = 'sign_up.dart';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _role = 'User';
  String? _selectedSpecialty; // 🔹 لتخزين التخصص المختار

  // قائمة التخصصات المتاحة
  final List<String> _specialties = [
    "General",
    "Cardiology",
    "Dermatology",
    "Neurology",
    "Pediatrics",
    "Psychiatry"
  ];

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      if (_role == "User") {
        final signupModel = SignupUserModel(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          confirmationPassword: _confirmPasswordController.text.trim(),
          role: _role,
        );
        context.read<AuthCubit>().signUpUser(signupModel);
      } else if (_role == "Doctor") {
        if (_selectedSpecialty == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a specialty')),
          );
          return;
        }

        final signupDoctorModel = SignupDoctorModel(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          confirmationPassword: _confirmPasswordController.text.trim(),
          specialty: _selectedSpecialty!, // 🔹 تمرير التخصص المختار
          role: _role,
        );
        context.read<AuthCubit>().signUpDoctor(signupDoctorModel);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: "Sign Up"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text('Role', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        activeColor: AppColors.primary,
                        title: Text('Patient', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16)),
                        value: 'User',
                        groupValue: _role,
                        onChanged: (value) => setState(() {
                          _role = value.toString();
                          _selectedSpecialty = null; // 🔹 إعادة تعيين التخصص عند تغيير الدور
                        }),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        activeColor: AppColors.primary,
                        title: Text('Doctor', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16)),
                        value: 'Doctor',
                        groupValue: _role,
                        onChanged: (value) => setState(() {
                          _role = value.toString();
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                if (_role == "Doctor") ...[
                  Text('Specialty', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16)),
                  DropdownButtonFormField<String>(
                    value: _selectedSpecialty,


                    hint: Text('Select Specialty', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 14)),
                    items: _specialties.map((specialty) {
                      return DropdownMenuItem(
                        value: specialty,
                        child: Text(specialty),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedSpecialty = value),
                    validator: (value) => value == null ? 'Please select a specialty' : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                Text('Username', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16)),
                MyTextField(
                  controller: _usernameController,
                  label: 'Enter your username',
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter your username' : null,
                ),
                const SizedBox(height: 16),

                Text('Email', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16)),
                MyTextField(
                  controller: _emailController,
                  label: 'example@example.com',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your email';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Invalid email format';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Text('Password', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16)),
                MyTextField(
                  controller: _passwordController,
                  label: '**********',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your password';
                    if (value.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Text('Confirm Password', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16)),
                MyTextField(
                  controller: _confirmPasswordController,
                  label: '**********',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please confirm your password';
                    if (value != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSignupSuccessDoctor) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Welcome Dr. ${state.doctor.username}!')),
                      );
                      Navigator.pushReplacementNamed(context, LogInScreen.routeName);
                    } else if (state is AuthSignupSuccessPatient) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Welcome ${state.patient.username}!')),
                      );
                      Navigator.pushReplacementNamed(context, LogInScreen.routeName);
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message.toString())),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,fixedSize: Size(100, 20)),
                        child: Text('Sign Up', style: AppStyle.bodyWhiteTextStyle),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
