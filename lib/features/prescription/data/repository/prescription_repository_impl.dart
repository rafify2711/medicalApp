import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/repository/prescription_repository.dart';
import '../models/prescription_response.dart';

@Injectable(as: PrescriptionRepository)
class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final ReadPerceptionClint readPerceptionClint;

  PrescriptionRepositoryImpl(this.readPerceptionClint);

  @override
  Future<PrescriptionResponse> readPrescription(File imagePath) async {
    try {
      if (await imagePath.exists()) {
        print("✅ file exists. path: ${imagePath.path}");
      } else {
        print("❌ file doesn't exist.");
      }

      // إرسال الصورة إلى الـ API
      final response = await readPerceptionClint.readPrescription(imagePath);

      // التحقق من وجود النص المُكتشف
      if (response.detectedText != null ) {
        log('${response.detectedText}0000');
      } else {
        log('No detected text available');
      }

      return response;
    } on DioException catch (dioError) {
      final errorMessage = dioError.response?.data['message'] ??
          dioError.message ??
          "حدث خطأ غير متوقع من السيرفر.";
      throw Exception(errorMessage); // ارجاع الخطأ برسالة أو موديل معين
    } catch (e) {
      // التعامل مع الأخطاء الأخرى
      throw Exception("حدث خطأ أثناء التنبؤ بالمرض: ${e.toString()}");
    }
  }
}
