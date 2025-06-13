import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/screens/log_in_screen.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/edit_profile/presentation/view/update_user_profile_screen.dart';
import '../../../../core/config/route_names.dart';
import '../../../../core/di/di.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../auth/presentation/view/privacy_policy_screen.dart';
import '../view_model/upload_photo_state.dart';
import '../view_model/user_profile_cubit.dart';
import '../view_model/upload_photo_cubit.dart';
import 'medical_record_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String token;
  final String userId;

  const ProfileScreen({required this.token, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<UserProfileCubit>()..fetchUserProfile(token, userId),
        ),
        BlocProvider(
          create: (context) => getIt<UploadProfilePhotoCubit>(),
        ),
      ],
      child: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.grey,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            final userData = state.profile.user;
            return Scaffold(
              backgroundColor: Colors.white,
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
                                  AppLocalizations.of(context).profile,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 48), // To balance the back button
                          ],
                        ),
                        SizedBox(height: 8),
                        // Avatar
                        CircleAvatar(
                          radius: 44,
                          backgroundImage: (userData.profileImage != null &&
                            (userData.profileImage!.startsWith('http://') || userData.profileImage!.startsWith('https://')))
                            ? NetworkImage(userData.profileImage!)
                            : AssetImage("lib/assets/img/default_avatar.png") as ImageProvider,
                          backgroundColor: Colors.grey[300],
                        ),
                        SizedBox(height: 12),
                        Text(
                          userData.username ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          userData.email ?? '',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            context,
                            Icons.person,
                            AppLocalizations.of(context).profile,
                            () async {
                              final result = await Navigator.pushNamed(
                                context,
                                RouteNames.updateProfile,
                                arguments: {
                                  'token': token,
                                  'userId': userId,
                                  'username': userData.username ?? '',
                                  'phone': userData.phone ?? '',
                                  'address': userData.adress,
                                  'medicationHistory': userData.medicationHistory,
                                  'medicalHistory': userData.medicalHistory,
                                  'dob': userData.dob,
                                  'profilePhoto': userData.profileImage,
                                },
                              );
                              
                              if (result == true) {
                                context.read<UserProfileCubit>().fetchUserProfile(token, userId);
                              }
                            },
                          ),
                          _buildMenuItem(
                            context,
                            Icons.medical_services,
                            'Medical Records',
                            () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MedicalRecordScreen(
                                    medicalHistory: userData.medicalHistory,
                                    medicationHistory: userData.medicationHistory,
                                  ),
                                ),
                              );
                              
                              if (result == true) {
                                context.read<UserProfileCubit>().fetchUserProfile(token, userId);
                              }
                            },
                          ),
                          _buildMenuItem(context, Icons.privacy_tip, AppLocalizations.of(context).privacyPolicy, (){ 
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                            );
                          }),
                          _buildMenuItem(context, Icons.settings, AppLocalizations.of(context).settings, (){Navigator.pushNamed(context, RouteNames.settings);}),
                          _buildMenuItem(
                            context,
                            Icons.logout,
                            AppLocalizations.of(context).logout,
                            () async {
                              await context.read<UserProfileCubit>().logout();
                              Navigator.popAndPushNamed(context, RouteNames.login);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserProfileError) {
            return Center(child: Text("${AppLocalizations.of(context).error}: ${state.message}"));
          }
          return Center(child: Text(AppLocalizations.of(context).noData));
        },
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback? onTap) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary1.withOpacity(0.1),
          ),
          padding: EdgeInsets.all(10),
          child: Icon(icon, color: AppColors.primary1, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }
}
