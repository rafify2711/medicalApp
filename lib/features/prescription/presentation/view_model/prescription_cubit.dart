import 'dart:convert'; // لتحويل الصورة إلى Base64
import 'dart:typed_data'; // للتعامل مع الصور في الويب
import 'dart:io'; // للتعامل مع الملفات في الهاتف
import 'package:flutter/foundation.dart'; // للكشف عن بيئة التشغيل
import 'package:bloc/bloc.dart';
import 'package:graduation_medical_app/core/di/di.dart';
import 'package:graduation_medical_app/features/prescription/data/models/prescription_response.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/read_prescription_use_case.dart';

part 'prescription_state.dart';


@injectable
class PrescriptionCubit extends Cubit<PrescriptionState> {
  final PrescriptionUseCase prescriptionUseCase;

  PrescriptionCubit(this.prescriptionUseCase) : super(PrescriptionInitial());

  Future<void> readPrescription( {File? imageFile, Uint8List? webImage}) async {
    emit(PrescriptionLoading());

    try {
      dynamic imageData;

      if (kIsWeb && webImage != null) {

        imageData = base64Encode(webImage);
      } else if (imageFile != null) {

        imageData = imageFile;


      } else {
        throw Exception("No image selected!");
      }

      final prediction = await prescriptionUseCase.read(imageData);
      print('detected_text: ${prediction.detectedText}');

      emit(PrescriptionSuccess(prediction));
    } catch (e) {
      emit(PrescriptionFailure(e.toString()));
      print(e.toString());
    }
  }
}
