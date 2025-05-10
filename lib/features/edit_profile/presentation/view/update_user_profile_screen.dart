import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import '../../../auth/presentation/view/widgets/button.dart';
import '../../../auth/presentation/view/widgets/my_text_field.dart';
import '../../data/models/updated_user_model.dart';
import '../view_model/update_user_Profile_cubit.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

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
  late String token;
  late String userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    print('UpdateProfileScreen arguments: ' + args.toString());
    if (args == null || args is! Map<String, dynamic>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).noProfileData)),
      );
      Future.microtask(() => Navigator.of(context).pop());
      return;
    }
    final map = args;
    token = map['token'] as String;
    userId = map['userId'] as String;
    _usernameController.text = map['username'] as String;
    _phoneController.text = map['phone'] as String;
    _addressController.text = map['address'] as String? ?? '';
    _medicationHistoryController.text = map['medicationHistory'] as String? ?? '';
    _dob = map['dob'] as DateTime?;
    profilePhotoUrl = map['profilePhoto'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary1.withOpacity(0.05),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).editProfile,
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppStyle.gradient,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<UpdateUserProfileCubit, UpdateUserProfileState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          if (state.userProfile != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Profile updated successfully!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary1),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _usernameController,
                    label: AppLocalizations.of(context).username,
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _phoneController,
                    label: AppLocalizations.of(context).phone,
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _addressController,
                    label: AppLocalizations.of(context).address,
                    prefixIcon: Icons.location_on,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _medicationHistoryController,
                    label: AppLocalizations.of(context).medicationHistory,
                    prefixIcon: Icons.medical_services,
                  ),
                  SizedBox(height: 16),

                  // DOB picker
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary1.withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: AppColors.primary1),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _dob == null
                                ? AppLocalizations.of(context).selectDateOfBirth
                                : '${AppLocalizations.of(context).dob}: ${_dob!.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(
                              color: _dob == null ? Colors.grey : Colors.black87,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today, color: AppColors.primary1),
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
                  ),
                  SizedBox(height: 24),

                  Button(
                    onClick: () async {
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
                    },
                    text: AppLocalizations.of(context).saveChanges,
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
