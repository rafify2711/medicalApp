
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/register_doctor_response.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/register_user_response.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/signup_doctor_model.dart';
import 'package:graduation_medical_app/features/auth/data/models/user_model/doctor_model.dart';
import 'package:graduation_medical_app/features/drug_conflict/data/models/drug_interaction_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/retrofit.dart' show Body, Field, GET, Header, MultiPart, POST, PUT, Part, Path, Query, RestApi;

import '../../features/Profile/data/models/user_profile_response.dart';
import '../../features/auth/data/models/sign_in_model/login_response.dart';
import '../../features/auth/data/models/sign_in_model/sign_in_model.dart';
import '../../features/auth/data/models/signup_model/signup_user_model.dart';

import '../../features/auth/data/models/user_model/doctors_model.dart';
import '../../features/medical_dignosis/data/models/prdiction_models/prediction_model.dart';



part 'api_client.g.dart';

@RestApi(baseUrl: "http://localhost:3000/")
abstract class ApiClient {

  @factoryMethod
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("auth/signup")
  Future<RegisterUserResponse> signupPatient(@Body() SignupUserModel model);

  @POST("auth/signup")
  Future<RegisterDoctorResponse> signupDoctor(@Body() SignupDoctorModel model);

  @POST("auth/login")
  Future<LoginResponse> login(@Body() SignInModel model);

  @GET("user/profile/{userId}")
  Future<UserProfileResponse> getUserProfile(
      @Header("Authorization") String  token,
      @Path("userId") String userId,
      );

  @GET("doctor/")
  Future<List<Doctor>> getAllDoctors();

  // 1. Drug Interaction Check
  @GET("api/drug-interactions/check")
  Future<DrugInteractionResponse> checkDrugInteraction(
      @Query("drug1") String drug1, @Query("drug2") String drug2);

  // 2. Get Drug Substitutions
  @GET("api/drug-interactions/substitutions")
  Future<DrugInteractionResponse> getDrugSubstitutions(@Query("drug") String drug);

  // 3. Disease Check for Drug Interaction
  @GET("api/drug-interactions/disease-check")
  Future<DrugInteractionResponse> checkDiseaseDrugInteraction(
      @Query("drug") String drug, @Query("disease") String disease);

}






@RestApi(baseUrl: "http://192.168.1.12:3000/api/")
abstract class ApiClientPrediction {

  factory ApiClientPrediction(Dio dio, {String baseUrl}) = _ApiClientPrediction;

  @POST("/covid19/predict")
  @MultiPart()
  Future<PredictionResponse> predictCovid19(@Part(name: "file") File? imagePath);

  @POST("/brain-tumor/predict?")
  Future<PredictionResponse> predictBrainTumor(@Part(name: "file") File? imagePath);

  @POST("/kidney-stone/predict")
  Future<PredictionResponse> predictKidneyStone(@Part(name: "file") File? imagePath);

  @POST("/skin-cancer/predict")
  Future<PredictionResponse> predictSkinCancer(@Part(name: "file") File? imagePath);

  @POST("/tuberculosis/predict")
  Future<PredictionResponse> predictTuberculosis(@Part(name: "file") File? imagePath);

  @POST("/bone-fracture/predict")
  Future<PredictionResponse> predictBoneFracture(@Part(name: "file") File? imagePath);


}
