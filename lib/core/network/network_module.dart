import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  @lazySingleton
  ApiClientLocalPrediction apiClientLocalPrediction(Dio dio) => ApiClientLocalPrediction(dio);

  @preResolve
  Future<SharedPreferences> get prefs async => await SharedPreferences.getInstance();

}






