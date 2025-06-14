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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary1.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).uploadImage,
                    style: AppStyle.titlesTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context).uploadClearImage,
                    style: AppStyle.bodyBlackTextStyle.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: _imageFile == null && _webImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 64, color: Colors.grey[400]),
                        SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context).noImageSelected,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
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

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: Icon(Icons.upload_file, color: AppColors.primary1),
                    label: Text(AppLocalizations.of(context).gallery),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary1,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: AppColors.primary1),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: Icon(Icons.camera_alt, color: AppColors.primary1),
                    label: Text(AppLocalizations.of(context).camera),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary1,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: AppColors.primary1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: Button(
                onClick: _readPrescription,
                text: AppLocalizations.of(context).read,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 24),

            BlocBuilder<PrescriptionCubit, PrescriptionState>(
              builder: (context, state) {
                if (state is PrescriptionLoading) {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(color: AppColors.primary1),
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
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).detectedText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
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
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red.shade200),
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
                                color: Colors.red[700],
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
    );
  }
}


