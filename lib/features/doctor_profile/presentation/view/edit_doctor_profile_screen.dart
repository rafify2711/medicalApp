import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/button.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_text_field.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';

import '../../data/models/update_doctor_model.dart';

class EditDoctorProfileScreen extends StatefulWidget {
  final DoctorModel profile;

  const EditDoctorProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  _EditDoctorProfileScreenState createState() => _EditDoctorProfileScreenState();
}

class _EditDoctorProfileScreenState extends State<EditDoctorProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Basic Info Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  final _experienceController = TextEditingController();
  late List<TextEditingController> _careerPathControllers;
  late List<TextEditingController> _highlightsControllers;
  
  // Contact Info Controllers
  final _facebookController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _twitterController = TextEditingController();
  final _websiteController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _contactPhoneController = TextEditingController();

  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final profile = widget.profile;
    _nameController.text = profile.name ?? '';
    _emailController.text = profile.email ?? '';
    _bioController.text = profile.bio ?? '';
    _experienceController.text = profile.experience?.toString() ?? '';
    _selectedGender = profile.gender ?? '';
    _careerPathControllers = (profile.careerPath != null && profile.careerPath!.isNotEmpty)
      ? profile.careerPath!.map((e) => TextEditingController(text: e)).toList()
      : [TextEditingController()];
    _highlightsControllers = (profile.highlights != null && profile.highlights!.isNotEmpty)
      ? profile.highlights!.map((e) => TextEditingController(text: e)).toList()
      : [TextEditingController()];
    if (profile.contact != null) {
      _facebookController.text = profile.contact?.facebook ?? '';
      _linkedinController.text = profile.contact?.linkedin ?? '';
      _twitterController.text = profile.contact?.twitter ?? '';
      _websiteController.text = profile.contact?.website ?? '';
      _whatsappController.text = profile.contact?.whatsapp ?? '';
      _contactPhoneController.text = profile.contact?.phone ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _experienceController.dispose();
    _facebookController.dispose();
    _linkedinController.dispose();
    _twitterController.dispose();
    _websiteController.dispose();
    _whatsappController.dispose();
    _contactPhoneController.dispose();
    super.dispose();
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
      body: BlocConsumer<DoctorProfileCubit, DoctorProfileState>(
        listener: (context, state) {
          if (state is DoctorProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          if (state is DoctorProfileLoaded) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary1),
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(AppLocalizations.of(context).basicInfo),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _nameController,
                    label: AppLocalizations.of(context).name,
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _emailController,
                    label: AppLocalizations.of(context).email,
                    prefixIcon: Icons.email,
                    enabled: false, // Email should not be editable
                  ),
                  SizedBox(height: 16),

                  MyTextField(
                    controller: _bioController,
                    label: AppLocalizations.of(context).bio,
                    prefixIcon: Icons.info,
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: TextEditingController(text: _selectedGender),
                    label: AppLocalizations.of(context).gender,
                    prefixIcon: Icons.transgender,
                    onChanged: (val) => _selectedGender = val,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _experienceController,
                    label: AppLocalizations.of(context).experience,
                    prefixIcon: Icons.work,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  _buildListSection(
                    context,
                    title: AppLocalizations.of(context).careerPath,
                    icon: Icons.timeline,
                    controllers: _careerPathControllers,
                    onAdd: () => setState(() => _careerPathControllers.add(TextEditingController())),
                    onRemove: (idx) => setState(() => _careerPathControllers.removeAt(idx)),
                  ),
                  SizedBox(height: 16),
                  _buildListSection(
                    context,
                    title: AppLocalizations.of(context).highlights,
                    icon: Icons.star,
                    controllers: _highlightsControllers,
                    onAdd: () => setState(() => _highlightsControllers.add(TextEditingController())),
                    onRemove: (idx) => setState(() => _highlightsControllers.removeAt(idx)),
                  ),
                  SizedBox(height: 24),
                  _buildSectionTitle(AppLocalizations.of(context).contactInfo),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _facebookController,
                    label: 'Facebook',
                    prefixIcon: Icons.facebook,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _linkedinController,
                    label: 'LinkedIn',
                    prefixIcon: Icons.link,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _twitterController,
                    label: 'Twitter',
                    prefixIcon: Icons.alternate_email,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _websiteController,
                    label: 'Website',
                    prefixIcon: Icons.language,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _whatsappController,
                    label: 'WhatsApp',
                    prefixIcon: Icons.chat,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    controller: _contactPhoneController,
                    label: AppLocalizations.of(context).contactPhone,
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(height: 32),
                  Button(
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        final contact = ContactModel(
                          facebook: _facebookController.text,
                          linkedin: _linkedinController.text,
                          twitter: _twitterController.text,
                          website: _websiteController.text,
                          whatsapp: _whatsappController.text,
                          phone: _contactPhoneController.text,
                        );

                        final updateModel = UpdateDoctorModel(
                          name: _nameController.text,
                          bio: _bioController.text,
                          experience: int.tryParse(_experienceController.text),
                          careerPath: _careerPathControllers.map((c) => c.text.trim()).where((e) => e.isNotEmpty).toList(),
                          highlights: _highlightsControllers.map((c) => c.text.trim()).where((e) => e.isNotEmpty).toList(),
                          contact: contact,
                          gender: _selectedGender,
                        );

                        context.read<DoctorProfileCubit>().updateProfile(
                          widget.profile.id!,
                          updateModel,
                        );
                      }
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primary1,
      ),
    );
  }

  Widget _buildListSection(BuildContext context, {required String title, required IconData icon, required List<TextEditingController> controllers, required VoidCallback onAdd, required void Function(int) onRemove}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary1)),
        ...controllers.asMap().entries.map((entry) {
          int idx = entry.key;
          return Row(
            children: [
              Expanded(
                child: MyTextField(
                  controller: entry.value,
                  label: '${title} ${idx + 1}',
                  prefixIcon: icon,
                ),
              ),
              if (controllers.length > 1)
                IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => onRemove(idx),
                ),
            ],
          );
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: onAdd,
            icon: Icon(Icons.add, color: AppColors.primary1),
            label: Text('Add'),
          ),
        ),
      ],
    );
  }
} 