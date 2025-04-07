import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import '../../../../core/di/di.dart';
import '../../../auth/presentation/view/widgets/my_app_par.dart';
import '../../../edit_profile/presentation/view/update_user_profile_screen.dart';
import '../view_model/doctor_profile_cubit.dart';

class DoctorProfileScreen extends StatelessWidget {
  static const routeName = 'doctor_screen';

  final String userId;

  const DoctorProfileScreen({ required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<DoctorProfileCubit>()..fetchDoctorProfile(
                userId,
              ), // Using getIt for dependency injection
      child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
        builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DoctorProfileLoaded) {
            final userData = state.profile;
            return Scaffold(
              appBar: MyAppPar(title: 'Hello ${userData.username}'),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Info Section
                    Center(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                userData.profilePhoto!.isNotEmpty
                                    ? NetworkImage(userData.profilePhoto!)
                                    : AssetImage(
                                          "lib/assets/img/default_avatar.png",
                                        )
                                        as ImageProvider,
                            backgroundColor: Colors.grey[800],
                          ),
                          SizedBox(width: 50),
                          Column(
                            children: [
                              Text(
                                userData.username, // Use the loaded user's name
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                userData.specialty ,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[400],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                userData.email, // Use the loaded email
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),

                    // Menu Items
                    _buildMenuItem(
                      context,
                      Icons.person,
                      'user_profile',
                      UpdateProfileScreen.routeName,
                    ),


                    _buildMenuItem(
                      context,
                      Icons.privacy_tip,
                      'Privacy Policy',
                       '',
                    ),
                    _buildMenuItem(context, Icons.settings, 'Settings', ''),
                    _buildMenuItem(context, Icons.help, 'Help', ''),
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          shape:
                              BoxShape
                                  .circle, // This makes the container circular
                          gradient:
                              AppStyle
                                  .gradient, // Set the background color here
                        ),
                        padding: EdgeInsets.all(
                          10,
                        ), // You can adjust padding to control the size of the circle
                        child: Icon(
                          Icons.logout, // Choose your icon here
                          color:
                              Colors
                                  .white, // Set the icon color (usually white for contrast)
                          size: 20, // Adjust the size of the icon
                        ),
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(color: AppColors.primary),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey[600],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          } else if (state is DoctorProfileError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return Center(child: Text("No data available"));
        },
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle, // This makes the container circular
          gradient: AppStyle.gradient, // Set the background color here
        ),
        padding: EdgeInsets.all(
          10,
        ), // You can adjust padding to control the size of the circle
        child: Icon(
          icon, // Choose your icon here
          color:
              Colors.white, // Set the icon color (usually white for contrast)
          size: 20, // Adjust the size of the icon
        ),
      ),
      title: Text(title, style: TextStyle(color: AppColors.primary)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
