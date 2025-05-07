import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart';

class EditDoctorProfileScreen extends StatefulWidget {
  final DoctorModel profile;

  const EditDoctorProfileScreen({super.key, required this.profile});

  @override
  State<EditDoctorProfileScreen> createState() => _EditDoctorProfileScreenState();
}

class _EditDoctorProfileScreenState extends State<EditDoctorProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _specialtyController;
  late TextEditingController _educationController;
  late TextEditingController _experienceController;
  late TextEditingController _workingDaysController;
  late TextEditingController _workingHoursController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.profile.username);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _specialtyController = TextEditingController(text: widget.profile.specialty);
  //  _educationController = TextEditingController(text: widget.profile.education);
    //_experienceController = TextEditingController(text: widget.profile.experience?.toString());
   // _workingDaysController = TextEditingController(text: widget.profile.workingDays);
   // _workingHoursController = TextEditingController(text: widget.profile.workingHours);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _specialtyController.dispose();
    _educationController.dispose();
    _experienceController.dispose();
    _workingDaysController.dispose();
    _workingHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorProfileCubit, DoctorProfileState>(
      listener: (context, state) {
        if (state is DoctorProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is DoctorProfileLoaded) {
          Navigator.pop(context, state.profile);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          actions: [
            TextButton(
              onPressed: _saveChanges,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: 'Personal Information',
                      children: [
                        _buildTextField(
                          controller: _usernameController,
                          label: 'Full Name',
                          icon: Icons.person,
                        ),
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        _buildTextField(
                          controller: _phoneController,
                          label: 'Phone',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        _buildTextField(
                          controller: _addressController,
                          label: 'Address',
                          icon: Icons.location_on,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    _buildSection(
                      title: 'Professional Information',
                      children: [
                        _buildTextField(
                          controller: _specialtyController,
                          label: 'Specialty',
                          icon: Icons.medical_services,
                        ),
                        _buildTextField(
                          controller: _educationController,
                          label: 'Education',
                          icon: Icons.school,
                        ),
                        _buildTextField(
                          controller: _experienceController,
                          label: 'Experience (years)',
                          icon: Icons.work,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    _buildSection(
                      title: 'Working Hours',
                      children: [
                        _buildTextField(
                          controller: _workingDaysController,
                          label: 'Working Days',
                          icon: Icons.calendar_today,
                          hint: 'e.g., Monday - Friday',
                        ),
                        _buildTextField(
                          controller: _workingHoursController,
                          label: 'Working Hours',
                          icon: Icons.access_time,
                          hint: 'e.g., 9:00 AM - 5:00 PM',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary1,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? hint,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.primary1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary1),
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    final updatedProfile = DoctorModel(
      username: _usernameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
     // address: _addressController.text,
      specialty: _specialtyController.text,
    //  education: _educationController.text,
     // experience: int.tryParse(_experienceController.text),
     // workingDays: _workingDaysController.text,
     // workingHours: _workingHoursController.text,
      // Add other fields as needed
    );

  //  context.read<DoctorProfileCubit>().updateDoctorProfile(updatedProfile);
  }
} 