import 'dart:convert'; // لتحويل الصورة إلى Base64
import 'dart:typed_data'; // للتعامل مع الصور في الويب
import 'dart:io'; // للتعامل مع الملفات في الهاتف
import 'package:flutter/foundation.dart'; // للكشف عن بيئة التشغيل
import 'package:bloc/bloc.dart';
import 'package:graduation_medical_app/core/di/di.dart';
import '../../domain/repository/prediction_repository.dart';
import '../../domain/use_cases/prediction_usecase.dart';
import '../../data/models/prdiction_models/prediction_model.dart';
import 'package:injectable/injectable.dart';

part 'prediction_state.dart';


@injectable
class PredictionCubit extends Cubit<PredictionState> {
  final PredictionUseCase predictionUseCase;

  PredictionCubit(this.predictionUseCase) : super(PredictionInitial());

  Future<void> predictDisease(String disease, {File? imageFile, Uint8List? webImage}) async {
    emit(PredictionLoading());

    try {
      dynamic imageData;

      if (kIsWeb && webImage != null) {

        imageData = base64Encode(webImage);
      } else if (imageFile != null) {

        imageData = imageFile;


      } else {
        throw Exception("No image selected!");
      }

      final prediction = await predictionUseCase.predict(disease, imageData);
      print('confidence: ${prediction.model}');
      print('predicted_class: ${prediction..model.predicted_class}');
      emit(PredictionSuccess(prediction.model));
    } catch (e) {
      emit(PredictionFailure(e.toString()));
      print(e.toString());
    }
  }
}
