import 'dart:io';

import 'package:dio/dio.dart';
import 'package:graduation_medical_app/features/medical_dignosis/data/models/prdiction_models/prediction_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/prediction_repository.dart';
import '../data_source/prediction_data_source.dart';

@Injectable(as: PredictionRepository)
class PredictionRepoImpl implements PredictionRepository {
  final PredictionDataSource predictionDataSource;

  PredictionRepoImpl(this.predictionDataSource);

  @override
  Future<PredictionResponse> predictDisease(String disease, File imagePath) async {
    try{if (await imagePath.exists()) {
      print("✅ file exists. path: ${imagePath.path}");
    } else {
      print("❌file doesn't exist.");
    }
    print(imagePath);

    final response = await predictionDataSource.predictDisease(disease, imagePath);
    return response;}
    on DioException catch (dioError) {
    // معالجة خطأ من Dio
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
  
