import 'dart:io';
import 'package:dio/dio.dart';
import 'package:graduation_medical_app/core/models/chat_message.dart';
import 'package:graduation_medical_app/features/auth/data/models/changePassword/change_password_data.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/register_doctor_response.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/register_user_response.dart';
import 'package:graduation_medical_app/features/auth/data/models/signup_model/signup_doctor_model.dart';
import 'package:graduation_medical_app/features/drug_conflict/data/models/drug_interaction_response.dart';
import 'package:graduation_medical_app/features/reservation/data/models/create_reservation_response.dart';
import 'package:graduation_medical_app/features/user_profile/data/models/Profile_image_response.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart'
    show
        Body,
        GET,
        Header,
        MultiPart,
        POST,
        PUT,
        Part,
        Path,
        Query,
        RestApi;
import '../../features/auth/data/models/changePassword/change_password_response.dart';
import '../../features/auth/data/models/changePassword/reset_password_data.dart';
import '../../features/auth/data/models/sign_in_model/login_response.dart';
import '../../features/auth/data/models/sign_in_model/sign_in_model.dart';
import '../../features/auth/data/models/signup_model/signup_user_model.dart';
import '../../features/chat_bot/data/models/chat_response.dart';
import '../../features/doctor_profile/data/models/update_doctor_model.dart';
import '../../features/doctor_profile/data/models/update_doctor_response.dart';
import '../../features/edit_profile/data/models/updated_user_model.dart';
import '../../features/medical_dignosis/data/models/prdiction_models/prediction_model.dart';
import '../../features/prescription/data/models/prescription_response.dart';
import '../../features/reservation/data/models/add_update_schedule_response.dart';
import '../../features/reservation/data/models/delete_schedule_data.dart';
import '../../features/user_appointment/data/models/doctor_model/doctor_model.dart';
import '../../features/user_appointment/data/models/user_get_reservation_response_model.dart';
import '../../features/user_profile/data/models/user_profile_response.dart';
import '../models/api_message_response.dart';
import '../models/appointment_model/reservation_data_model.dart';
import '../models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/reservation/data/models/schedule_response.dart';
import '../models/doctor_appointment_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://medicalapp-sku9qeo9.b4a.run/")
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
      @Header("Authorization") String token,
      @Path("userId") String userId,);

  @GET("doctor/{doctorId}")
  Future<DoctorModel> getDoctorProfile(@Path("doctorId") String userId);

  @GET("/user/{userId}/reservations")
  Future<UserGetReservationResponseModel> getUserAppointments(
      @Path("userId") String userId,
      @Header("Authorization") String token,);

  @GET("/doctor/{doctorId}/available-slots/{date}")
  Future<List<String>> getAvailableSlots(@Path("doctorId") String doctorId,
      @Path("date") DateTime date,);

  @PUT("doctor/{doctorId}/schedule/add")
  Future<AddUpdateScheduleResponse> addUpdateSchedule(
      @Path("doctorId") String doctorId,
      @Header("Authorization") String token,
      @Body() AddUpdateScheduleData data,);

  @PATCH('user/profile')
  Future<UserProfileResponse> updateUserProfile(
      @Header("Authorization") String token,
      @Body() UpdateUserModel user,);

  @GET("doctor/")
  Future<List<DoctorsModel>> getAllDoctors();

  @GET("api/drug-interactions/check")
  Future<DrugInteractionResponse> checkDrugInteraction(
      @Query("drug1") String drug1,
      @Query("drug2") String drug2,);

  @GET("api/drug-interactions/substitutions")
  Future<DrugInteractionResponse> getDrugSubstitutions(
      @Query("drug") String drug,);

  @POST("reservation")
  Future<CreateReservationResponse> createReservation(
      @Body() ReservationDataModel data,);

  @GET("api/drug-interactions/disease-check")
  Future<DrugInteractionResponse> checkDiseaseDrugInteraction(
      @Query("drug") String drug,
      @Query("disease") String disease,);

  @GET("api/chat/chat-history/")
  Future<List<ChatMessage>> fetchChatHistory(@Query('email') String email);

  @POST("api/chat/send-message")
  Future<ChatResponse> sendMessage(@Body() SendMessageData message);

  @DELETE("api/chat/delete-chat")
  Future<ApiMessageResponse> deleteChat(@Query('email') String userId);

  @PUT("doctor/{doctorId}")
  Future<UpdateDoctorResponse> updateDoctorProfile(
      @Path("doctorId") String userId,
      @Body() UpdateDoctorModel model,);

  @GET("doctor/{doctorId}/schedule")
  Future<ScheduleResponse> fetchDoctorSchedule(
      @Path("doctorId") String doctorId,
      @Header("Authorization") String token,);

  @GET("/doctor/{doctorId}/reservations")
  Future<ReservationResponse> fetchDoctorAppointments(
      @Path("doctorId") String doctorId,
      @Header("Authorization") String token,);

  @GET("/user/profile/password")
  Future<ChangePasswordResponse> changePassword(
      @Header("Authorization") String token,
      @Body() ChangePasswordData data,);

  @PATCH("user/profile/image")
  @MultiPart()
  Future<ProfileImageResponse> updateProfileImage(
      @Header("Authorization") String token,
      @Part(name: "profileImage") File? profileImage,);

  @POST("/auth/forgot-password")
  Future<ApiMessageResponse> forgetPassword(@Body() Email email,);

  @PATCH("/auth/reset-password")
  Future<ApiMessageResponse> resetPassword(@Body() ResetPasswordData data,);

  @PUT("/reservation/cancel/{reservationId}")
  Future<ApiMessageResponse> cancelReservation(
      @Path("reservationId") String reservationId,
      @Header("Authorization") String token,);

  @DELETE("doctor/{doctorId}/delete-schedule")
  Future<ApiMessageResponse> deleteSchedule(@Path("doctorId") String doctorId,
      @Header("Authorization") String token,
      @Body()    DeleteScheduleData data, );
}

@RestApi(baseUrl: "https://medicalapp-sku9qeo9.b4a.run/api/")
abstract class ApiClientPrediction {
  factory ApiClientPrediction(Dio dio, {String baseUrl}) = _ApiClientPrediction;

  @POST("/covid19/predict")
  @MultiPart()
  Future<PredictionResponse> predictCovid19(
    @Part(name: "file") File? imagePath,
  );

  @POST("/braintumor/predict?")
  Future<PredictionResponse> predictBrainTumor(
    @Part(name: "file") File? imagePath,
  );

  @POST("/kidneystone/predict")
  Future<PredictionResponse> predictKidneyStone(
    @Part(name: "file") File? imagePath,
  );

  @POST("/skincancer/predict")
  Future<PredictionResponse> predictSkinCancer(
    @Part(name: "file") File? imagePath,
  );

  @POST("/tuberculosis/predict")
  Future<PredictionResponse> predictTuberculosis(
    @Part(name: "file") File? imagePath,
  );


  @POST("/eye-diseases/predict")
  Future<PredictionResponse> predictEyeDiseases(
    @Part(name: "file") File? imagePath,
  );
  @POST("/alzheimer/predict")
  Future<PredictionResponse> predictAlzheimer(
    @Part(name: "file") File? imagePath,
  );
}

@RestApi(baseUrl: "https://medical-ai-production.up.railway.app/predict")
abstract class ReadPerceptionClint {
  factory ReadPerceptionClint(Dio dio, {String baseUrl}) = _ReadPerceptionClint;

  @POST("/prescription/")
  Future<PrescriptionResponse> readPrescription(
    @Part(name: "file") File? imagePath,
  );
}

@RestApi(baseUrl: "http://192.168.1.3:8000/predict")
abstract class ApiClientLocalPrediction{
  factory ApiClientLocalPrediction(Dio dio, {String baseUrl}) = _ApiClientLocalPrediction;
  @POST("/dental/")
  Future<PredictionResponse> predictDental(
      @Part(name: "file") File? imagePath,
      );
  @POST("/colon-diseases/")
  Future<PredictionResponse> predictColon(
      @Part(name: "file") File? imagePath,
      );

  @POST("/oral-diseases/")
  Future<PredictionResponse> predictOral(
      @Part(name: "file") File? imagePath,
      );

}



