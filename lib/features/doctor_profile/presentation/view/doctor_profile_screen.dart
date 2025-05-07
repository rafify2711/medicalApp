import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view/edit_doctor_profile_screen.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart';

import '../../../../core/di/di.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String userId;

  const DoctorProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DoctorProfileCubit>()..fetchDoctorProfile(userId),
      child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
        builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DoctorProfileLoaded) {
            final profile = state.profile;
            return Scaffold(
              backgroundColor: AppColors.primary1.withOpacity(0.05),
              body: Column(
                children: [
                  // Gradient Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 60, bottom: 24),
                    decoration: BoxDecoration(
                      gradient: AppStyle.gradient,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Back button and title
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Doctor Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.editDoctorProfile,
                                  arguments: profile,
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Avatar
                        CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.white,
                          child: Text(
                            profile.username?[0].toUpperCase() ?? 'D',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary1,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          profile.username ?? 'Doctor',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          profile.specialty ?? 'Specialist',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          profile.email ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Profile Information
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildInfoCard(
                              title: 'Personal Information',
                              children: [
                                _buildInfoRow(Icons.email, 'Email', profile.email ?? 'Not provided'),
                                _buildInfoRow(Icons.phone, 'Phone', profile.phone ?? 'Not provided'),
                                //_buildInfoRow(Icons.phone, 'Phone', profile.phone ?? 'Not provided'),
                              ],
                            ),
                            SizedBox(height: 16),
                            _buildInfoCard(
                              title: 'Professional Information',
                              children: [
                                _buildInfoRow(Icons.medical_services, 'Specialty', profile.specialty ?? 'Not provided'),
                                _buildInfoRow(Icons.school, 'Education', 'Not provided'),
                                _buildInfoRow(Icons.work, 'Experience', ' years'),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DoctorProfileError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No data available"));
        },
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary1.withOpacity(0.1),
            ),
            child: Icon(icon, color: AppColors.primary1, size: 22),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 