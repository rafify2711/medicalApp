import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/screens/log_in_screen.dart';
import 'package:graduation_medical_app/features/doctor_home/presentation/doctor_home_screen.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../data/models/signup_model/signup_doctor_model.dart';
import '../../../data/models/signup_model/signup_user_model.dart';
import '../../view_model/auth_cubit.dart';
import '../widgets/button.dart';
import '../widgets/my_app_par.dart';
import '../widgets/my_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
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
  String? _selectedSpecialty;


  final List<String> _specialties = [
  "General Practitioner",
  "Family Medicine",
  "Internal Medicine",
  "Cardiology",
  "Neurology",
  "Endocrinology",
  "Pulmonology",
  "Gastroenterology",
  "Nephrology",
  "Rheumatology",
  "General Surgery",
  "Orthopedic Surgery",
  "Neurosurgery",
  "Plastic Surgery",
  "Emergency Medicine",
  "Obstetrics & Gynecology",
  "Pediatrics",
  "Neonatology",
  "Psychiatry",
  "Psychology",
  "Dermatology",
  "Ophthalmology",
  "Otolaryngology (ENT)",
  "Allergy & Immunology",
  "Oncology",
  "Hematology",
  "Infectious Diseases",
  "Anesthesiology",
  "Geriatrics",
  "Urology"

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
          username: 'DR-${_usernameController.text.trim()}',
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          confirmationPassword: _confirmPasswordController.text.trim(),
          specialty: _selectedSpecialty!,
          role: _role,
        );
        print(signupDoctorModel.username);
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
                Text('Role', style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 18)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        activeColor: AppColors.primary1,
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
                        activeColor: AppColors.primary1,
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
                      style: AppStyle.bodyCyanTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,),
                    value: _selectedSpecialty,

                    hint: Text('Select Specialty',  style: AppStyle.bodyCyanTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,)),

                    items: _specialties.map((specialty) {
                      return DropdownMenuItem(

                        value: specialty,
                        child: Text(specialty),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedSpecialty = value),
                    validator: (value) => value == null ? 'Please select a specialty' : null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.fill,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
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
                Center(child: Text('By continuing, you agree to ',textAlign: TextAlign.center,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  InkWell(child: Text('Terms of Use ',style: AppStyle.bodyCyanTextStyle.copyWith(fontSize: 14,color: AppColors.primary1),)),
                    Text(' and '),
                    InkWell(child: Text(' Privacy Policy,',style: AppStyle.bodyCyanTextStyle.copyWith(fontSize: 14,color: AppColors.primary1))),
                  ],
                ),
                const SizedBox(height: 12),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSignupSuccessDoctor) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Welcome Dr. ${state.doctor.username}!')),
                      );
                      Navigator.pushReplacementNamed(context, RouteNames.login);
                    } else if (state is AuthSignupSuccessPatient) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Welcome ${state.patient.username}!')),
                      );
                      Navigator.pushReplacementNamed(context, RouteNames.login);
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
                      child:Button(
                        onClick: _signUp,
                        text:'Sign Up',
                        color: AppColors.primary,

                      ),
                    );
                  },
                ),
                SizedBox(height: 10,),
                Center(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do you have an account? ",
                        style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 14,color: AppColors.black,fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                          child: Text("Log in",
                            style: AppStyle.bodyCyanTextStyle.copyWith(fontSize: 14,color: AppColors.primary1,fontWeight: FontWeight.w500),),
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.signUp);}
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
