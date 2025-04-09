
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/repository/prescription_repository.dart';
import '../models/prescription_response.dart';

@Injectable(as: PrescriptionRepository)
class PrescriptionRepositoryImpl implements PrescriptionRepository{


  final ReadPerceptionClint readPerceptionClint;

  PrescriptionRepositoryImpl(this.readPerceptionClint);

  @override
  Future<PrescriptionResponse> readPrescription (File imagePath) async {
    try{if (await imagePath.exists()) {
      print("✅ file exists. path: ${imagePath.path}");
    } else {
      print("❌file doesn't exist.");
    }
    print(imagePath);

    final response = await readPerceptionClint.readPrescription( imagePath);
    return response;}
    on DioException catch (dioError) {
      final errorMessage = dioError.response?.data['message'] ??
          dioError.message ??
          "حدث خطأ غير متوقع من السيرفر.";
      throw Exception(errorMessage); // ممكن ترجعها برسالة أو موديل معين
    } catch (e) {
      // أي خطأ تاني مش متوقع
      throw Exception("حدث خطأ أثناء التنبؤ بالمرض: ${e.toString()}");
    }
  }
}

