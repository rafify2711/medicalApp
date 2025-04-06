import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import '../../../../core/di/di.dart';
import '../view_model/user_profile_cubit.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = 'user_profile_screen.dart';
  final String token;
  final String userId;

  UserProfileScreen({required this.token, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: "Profile"),
      body: BlocProvider(
        create: (context) => getIt<UserProfileCubit>()..fetchUserProfile(token, userId), // Use getIt here
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserProfileLoaded) {
              final userData = state.profile.user;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: userData.profilePhoto!.isNotEmpty?
                           NetworkImage(userData.profilePhoto!)
                          : AssetImage("lib/assets/img/default_avatar.png") as ImageProvider,
                    ),
                    SizedBox(height: 16),
                    buildTextField("Full Name", userData.username),
                    buildTextField("Phone Number", userData.phone ?? "N/A"),
                    buildTextField("Email", userData.email),

                    buildTextField("Reservations", userData.reservations.toString()),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Update Profile"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserProfileError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return Center(child: Text("No data available"));
          },
        ),
      ),
    );
  }

  Widget buildTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        controller: TextEditingController(text: value),
        readOnly: true,
      ),
    );
  }
}
