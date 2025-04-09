import 'dart:io';

import '../../data/models/prescription_response.dart';

abstract class PrescriptionRepository {
  Future<PrescriptionResponse> readPrescription(File imagePath);}