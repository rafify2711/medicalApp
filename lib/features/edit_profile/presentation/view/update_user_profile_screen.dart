import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/view/widgets/button.dart';
import '../../../auth/presentation/view/widgets/my_text_field.dart';
import '../../data/models/updated_user_model.dart';
import '../view_model/update_user_Profile_cubit.dart';
class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = 'update_profile_screen.dart';
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}
class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _medicationHistoryController = TextEditingController();

  DateTime? _dob;
  String? profilePhotoUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile")),
      body: BlocConsumer<UpdateUserProfileCubit, UpdateUserProfileState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }

          if (state.userProfile != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile updated successfully!")),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.userProfile != null) {
            _usernameController.text = state.userProfile!.user.username ?? '';
            _phoneController.text = state.userProfile!.user.phone ?? '';
            _addressController.text = state.userProfile!.user.adress ?? '';
            _medicationHistoryController.text =
                state.userProfile!.user.medicationHistory ?? '';
            _dob = state.userProfile!.user.dob;
            profilePhotoUrl = state.userProfile!.user.profilePhoto ?? '';
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  MyTextField(controller: _usernameController, label: "Username"),
                  SizedBox(height: 16),
                  MyTextField(controller: _phoneController, label: "Phone"),
                  SizedBox(height: 16),
                  MyTextField(controller: _addressController, label: "Address"),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _medicationHistoryController,
                    label: "Medication History",
                  ),
                  SizedBox(height: 16),

                  // DOB picker
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _dob == null
                              ? 'Select Date of Birth'
                              : 'DOB: ${_dob!.toLocal().toString().split(' ')[0]}',
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _dob ?? DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _dob = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Button(
                    onClick: () async {
                      final token = ""; // Replace this with actual token
                      final user = UpdateUserModel(
                        username: _usernameController.text,
                        phone: _phoneController.text,
                        dob: _dob,
                        address: _addressController.text,
                        medicationHistory: _medicationHistoryController.text,
                      );
                      await context
                          .read<UpdateUserProfileCubit>()
                          .updateProfile(token, user);
                      Navigator.pop(context);


                    },
                    text: "Update Profile",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
