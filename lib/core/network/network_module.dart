import 'package:dio/dio.dart';
import 'package:graduation_medical_app/features/prescription/data/models/prescription_response.dart';


import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_source/auth_local_data_source.dart';
import '../../features/auth/domain/use_cases/log_in_use_case.dart';
import '../../features/auth/domain/use_cases/signup_use_case.dart';
import '../../features/auth/presentation/view_model/auth_cubit.dart';
import '../utils/shared_prefs.dart';
import 'api_client.dart';


@module
abstract class NetworkModule {


  @lazySingleton
  Dio get dio {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    return dio;
  }
  @lazySingleton
  ApiClientPrediction apiClientPrediction(Dio dio) =>
      ApiClientPrediction(dio);
  @lazySingleton
  ApiClient apiClient(Dio dio) => ApiClient(dio);
  @lazySingleton
  ReadPerceptionClint prescriptionClient(Dio dio) => ReadPerceptionClint(dio);

  @preResolve
  Future<SharedPreferences> get prefs async => await SharedPreferences.getInstance();

}






