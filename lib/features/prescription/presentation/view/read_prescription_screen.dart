import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/prescription/presentation/view_model/prescription_cubit.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../auth/presentation/view/widgets/button.dart';
import '../../../auth/presentation/view/widgets/my_app_par.dart';

class ReadPrescriptionScreen extends StatefulWidget {
  const ReadPrescriptionScreen({Key? key}) : super(key: key);

  @override
  _ReadPrescriptionScreen createState() => _ReadPrescriptionScreen();
}

class _ReadPrescriptionScreen extends State<ReadPrescriptionScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  Uint8List? _webImage;

  @override
  void dispose() {
    _imageFile = null;
    _webImage = null;
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImage = bytes;
          _imageFile = null;
        });
      } else {
        setState(() {
          _imageFile = File(pickedFile.path);
          _webImage = null;
        });
      }
    }
  }

  void _readPrescription() {
    if (_imageFile != null || _webImage != null) {
      context.read<PrescriptionCubit>().readPrescription(
        imageFile: _imageFile,
        webImage: _webImage,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).selectImageFirst),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: AppLocalizations.of(context).readPrescription),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image Preview Section
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: _imageFile == null && _webImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 80, color: Colors.grey[400]),
                          SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context).noImageSelected,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: kIsWeb && _webImage != null
                            ? Image.memory(_webImage!, fit: BoxFit.cover)
                            : Image.file(_imageFile!, fit: BoxFit.cover),
                      ),
              ),
              SizedBox(height: 24),

              // Image Selection Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildImageButton(
                    icon: Icons.upload,
                    label: AppLocalizations.of(context).uploadImage,
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                  SizedBox(width: 16),
                  _buildImageButton(
                    icon: Icons.camera_alt,
                    label: AppLocalizations.of(context).takePhoto,
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Read Button
              Button(
                onClick: _readPrescription,
                text: AppLocalizations.of(context).read,
              ),
              SizedBox(height: 24),

              // Result Section
              BlocBuilder<PrescriptionCubit, PrescriptionState>(
                builder: (context, state) {
                  if (state is PrescriptionLoading) {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                          SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context).processingImage,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is PrescriptionSuccess) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green[700]),
                              SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context).detectedText,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: SelectableText(
                              state.prescription.detectedText ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is PrescriptionFailure) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.red.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red[700]),
                              SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context).error,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            state.error,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[700],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


