import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/prescription/presentation/view_model/prescription_cubit.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/app_style.dart';
import '../../../auth/presentation/view/widgets/button.dart';
import '../../../auth/presentation/view/widgets/my_app_par.dart';


class ReadPrescriptionScreen extends StatefulWidget {



  const ReadPrescriptionScreen({Key? key,}) : super(key: key);

  @override
  _ReadPrescriptionScreen createState() => _ReadPrescriptionScreen();
}

class _ReadPrescriptionScreen extends State<ReadPrescriptionScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  Uint8List? _webImage;

  @override
  void dispose() {
    // Clean up resources when the screen is popped
    _imageFile = null;
    _webImage = null;



    // Call the superclass dispose method to ensure proper cleanup
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
          content: Text("Please select an image first"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: "Read Prescription"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display selected image
            if (_imageFile == null && _webImage == null)
              Column(
                children: [
                  Icon(Icons.image, size: 100, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'No image selected',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              )
            else
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                  kIsWeb && _webImage != null
                      ? Image.memory(_webImage!, fit: BoxFit.cover)
                      : Image.file(_imageFile!, fit: BoxFit.cover),
                ),
              ),

            SizedBox(height: 20),

            // Image selection buttons
            Wrap(
              spacing: 20,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(AppColors.white),
                    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.upload, color: AppColors.primary),
                  label: Text(
                    'Upload Image',
                    style: AppStyle.bodyCyanTextStyle,
                  ),
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(AppColors.white),
                    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt, color: AppColors.primary),
                  label: Text(
                    'Take a Photo',
                    style: AppStyle.bodyCyanTextStyle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Button(onClick: _readPrescription, text: ' Read'),
            SizedBox(height: 20),
            // Display response
            BlocBuilder<PrescriptionCubit, PrescriptionState>(
              builder: (context, state) {
                if (state is PrescriptionLoading) {
                  return CircularProgressIndicator();
                } else if (state is PrescriptionSuccess) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prediction:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        SizedBox(height: 5),
                        SelectableText(
                          " ${state.prescription.detectedText}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),

                      ],
                    ),
                  );
                } else if (state is PrescriptionFailure) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Error:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                        ),
                        SizedBox(height: 5),
                        SelectableText(
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


