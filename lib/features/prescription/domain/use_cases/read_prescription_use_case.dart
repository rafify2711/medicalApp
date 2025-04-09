
import 'dart:io';

import 'package:graduation_medical_app/features/medical_dignosis/data/models/prdiction_models/prediction_model.dart';
import 'package:graduation_medical_app/features/medical_dignosis/domain/repository/prediction_repository.dart';
import 'package:graduation_medical_app/features/prescription/data/models/prescription_response.dart';
import 'package:graduation_medical_app/features/prescription/domain/repository/prescription_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PrescriptionUseCase {
  final PrescriptionRepository prescriptionRepository;

  PrescriptionUseCase(this.prescriptionRepository);

  Future<PrescriptionResponse> read( File imagePath) {
    return prescriptionRepository.readPrescription(imagePath);

  }
}
