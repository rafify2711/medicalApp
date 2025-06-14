import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import '../../../auth/presentation/view/widgets/button.dart';
import '../../../auth/presentation/view/widgets/my_text_field.dart';
import '../../../user_profile/presentation/view_model/upload_photo_state.dart';
import '../../data/models/updated_user_model.dart';
import '../view_model/update_user_Profile_cubit.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:graduation_medical_app/features/user_profile/presentation/view_model/upload_photo_cubit.dart';
import 'package:graduation_medical_app/core/di/di.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  final _medicationHistoryController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _imageUrl;

  DateTime? _dob;
  String? profilePhotoUrl;
  late String token;
  late String userId;
  List<String> medicalHistory = [];
  List<String> medicationHistory = [];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 1000,
        maxHeight: 1000,
        preferredCameraDevice: CameraDevice.rear,
      );
      
      if (pickedFile != null) {
        if (kIsWeb) {
          setState(() {
            _imageUrl = pickedFile.path;
          });
        } else {
          final File imageFile = File(pickedFile.path);
          // Validate image file
          final String extension = imageFile.path.split('.').last.toLowerCase();
          final List<String> validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
          
          if (!validExtensions.contains(extension)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please select a valid image file (jpg, jpeg, png, gif)'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          // Check file size
          final bytes = await imageFile.readAsBytes();
          if (bytes.length > 5 * 1024 * 1024) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Image size should be less than 5MB'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          setState(() {
            _imageFile = imageFile;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera, color: AppColors.primary1),
                title: Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: AppColors.primary1),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImage() {
    if (kIsWeb) {
      // Web platform
      if (_imageUrl != null) {
        return Image.network(
          _imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultProfileIcon();
          },
        );
      }
    } else {
      // Mobile platform
      if (_imageFile != null) {
        return Image.file(
          _imageFile!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultProfileIcon();
          },
        );
      }
    }

    // Show existing profile photo or default icon
    if (profilePhotoUrl != null) {
      return Image.network(
        profilePhotoUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultProfileIcon();
        },
      );
    }

    return _buildDefaultProfileIcon();
  }

  Widget _buildDefaultProfileIcon() {
    return Icon(
      Icons.person,
      size: 60,
      color: AppColors.primary1,
    );
  }

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
    
    // Initialize medical history list
    if (map['medicalHistory'] != null) {
      if (map['medicalHistory'] is List) {
        medicalHistory = List<String>.from(map['medicalHistory']);
      } else if (map['medicalHistory'] is String) {
        medicalHistory = [map['medicalHistory'] as String];
      }
    }
    
    // Initialize medication history list
    if (map['medicationHistory'] != null) {
      if (map['medicationHistory'] is List) {
        medicationHistory = List<String>.from(map['medicationHistory']);
      } else if (map['medicationHistory'] is String) {
        medicationHistory = [map['medicationHistory'] as String];
      }
    }
    
    // Handle DOB
    if (map['dob'] != null) {
      if (map['dob'] is DateTime) {
        _dob = map['dob'] as DateTime;
      } else if (map['dob'] is String) {
        try {
          _dob = DateTime.parse(map['dob'] as String);
        } catch (e) {
          print('Error parsing DOB: $e');
        }
      }
    }
    
    profilePhotoUrl = map['profilePhoto'] as String?;
  }

  String _calculateAge(DateTime? dob) {
    if (dob == null) return '';
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age.toString();
  }

  void _showMedicalHistoryDetails(String item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Medical History Details'),
        content: Text(item),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(String title, List<String> items, TextEditingController controller, Function(String) onAdd, Function(int) onRemove) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary1,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: MyTextField(
                controller: controller,
                label: 'Add new item',
                prefixIcon: Icons.add,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    onAdd(value);
                    controller.clear();
                  }
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: AppColors.primary1),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  onAdd(controller.text);
                  controller.clear();
                }
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        ...items.asMap().entries.map((entry) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text(entry.value),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => onRemove(entry.key),
              ),
              onTap: () => _showMedicalHistoryDetails(entry.value),
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<UpdateUserProfileCubit, UpdateUserProfileState>(
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
                Navigator.pop(context, true);
              }
            },
          ),
          BlocListener<UploadProfilePhotoCubit, UploadProfilePhotoState>(
            listener: (context, state) {
              if (state is UploadProfilePhotoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is UploadProfilePhotoSuccess) {
                // Update the profile photo URL
                setState(() {
                  profilePhotoUrl = state.response.imageUrl;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Photo uploaded successfully!"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<UpdateUserProfileCubit, UpdateUserProfileState>(
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
                    
                    // Profile Photo Section
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary1,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: _buildProfileImage(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary1,
                                shape: BoxShape.circle,
                              ),
                              child: BlocBuilder<UploadProfilePhotoCubit, UploadProfilePhotoState>(
                                builder: (context, state) {
                                  return IconButton(
                                    icon: state is UploadProfilePhotoLoading
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          )
                                        : Icon(Icons.camera_alt, color: Colors.white),
                                    onPressed: state is UploadProfilePhotoLoading
                                        ? null
                                        : _showImagePickerModal,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

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
                    SizedBox(height: 24),
                    
                    // Medical History Section
                    _buildListSection(
                      'Medical History',
                      medicalHistory,
                      _medicalHistoryController,
                      (item) => setState(() => medicalHistory.add(item)),
                      (index) => setState(() => medicalHistory.removeAt(index)),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Medication History Section
                    _buildListSection(
                      'Medication History',
                      medicationHistory,
                      _medicationHistoryController,
                      (item) => setState(() => medicationHistory.add(item)),
                      (index) => setState(() => medicationHistory.removeAt(index)),
                    ),
                    
                    SizedBox(height: 24),

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
                                  : '${AppLocalizations.of(context).dob}: ${_dob!.toLocal().toString().split(' ')[0]} (Age: ${_calculateAge(_dob)})',
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
                        if (_usernameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Username is required')),
                          );
                          return;
                        }

                        // First upload the photo if there's a new one
                        if (_imageFile != null) {
                          try {
                            await context.read<UploadProfilePhotoCubit>().uploadProfilePhoto(_imageFile!);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to upload photo: ${e.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                        }
                        
                        // Then update the profile
                        final user = UpdateUserModel(
                          username: _usernameController.text,
                          phone: _phoneController.text,
                          dob: _dob,
                          address: _addressController.text,
                          medicationHistory: medicationHistory,
                          medicalHistory: medicalHistory,
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
      ),
    );
  }
}
