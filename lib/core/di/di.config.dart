// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/data_source/auth_local_data_source.dart'
    as _i280;
import '../../features/auth/data/data_source/auth_remote_data_source__impl.dart'
    as _i456;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/use_cases/change_password_usecase.dart'
    as _i771;
import '../../features/auth/domain/use_cases/log_in_use_case.dart' as _i957;
import '../../features/auth/domain/use_cases/signup_use_case.dart' as _i571;
import '../../features/auth/presentation/view_model/auth_cubit.dart' as _i208;
import '../../features/auth/presentation/view_model/change_password_cubit.dart'
    as _i472;
import '../../features/chat_bot/data/repository/chat_repository_impl.dart'
    as _i257;
import '../../features/chat_bot/domain/repository/chat_repository.dart'
    as _i1008;
import '../../features/chat_bot/domain/use_cases/delete_chat_use-case.dart'
    as _i557;
import '../../features/chat_bot/domain/use_cases/fetch_chat_history_use_case.dart'
    as _i11;
import '../../features/chat_bot/domain/use_cases/send_message_use_case.dart'
    as _i546;
import '../../features/chat_bot/presentation/view_model/chat_cubit.dart'
    as _i36;
import '../../features/doctor_profile/data/repository/doctor_profile_repository_impl.dart'
    as _i289;
import '../../features/doctor_profile/domain/repository/doctor_profile_repository.dart'
    as _i478;
import '../../features/doctor_profile/domain/use_cases/user/doctor_profile_usecase.dart'
    as _i444;
import '../../features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart'
    as _i64;
import '../../features/drug_conflict/data/data_source/drug_interaction_data_source.dart'
    as _i727;
import '../../features/drug_conflict/data/repository/drug_interaction_repository_impl.dart'
    as _i33;
import '../../features/drug_conflict/domain/repository/drug_iteraction_repository.dart'
    as _i729;
import '../../features/drug_conflict/domain/use_cases/drug_interaction_use_case.dart'
    as _i917;
import '../../features/drug_conflict/presentation/view_model/check_drug_interaction_cubit.dart'
    as _i525;
import '../../features/drug_conflict/presentation/view_model/disease_drug_interaction_cubit.dart'
    as _i607;
import '../../features/drug_conflict/presentation/view_model/drug_substitutions_cubit.dart'
    as _i994;
import '../../features/edit_profile/data/repository/update_user_profile_repository.dart'
    as _i440;
import '../../features/edit_profile/domain/repository/updateUser_profile_repository.dart'
    as _i440;
import '../../features/edit_profile/domain/use_cases/update_user_profile_usecase.dart'
    as _i401;
import '../../features/edit_profile/presentation/view_model/update_user_Profile_cubit.dart'
    as _i584;
import '../../features/medical_dignosis/data/data_source/prediction_data_source.dart'
    as _i352;
import '../../features/medical_dignosis/data/repository/prediction_repository_impl.dart'
    as _i60;
import '../../features/medical_dignosis/domain/repository/prediction_repository.dart'
    as _i529;
import '../../features/medical_dignosis/domain/use_cases/prediction_usecase.dart'
    as _i640;
import '../../features/medical_dignosis/presentation/view_model/prediction_cubit.dart'
    as _i501;
import '../../features/prescription/data/repository/prescription_repository_impl.dart'
    as _i582;
import '../../features/prescription/domain/repository/prescription_repository.dart'
    as _i913;
import '../../features/prescription/domain/use_cases/read_prescription_use_case.dart'
    as _i865;
import '../../features/prescription/presentation/view_model/prescription_cubit.dart'
    as _i1051;
import '../../features/reservation/data/repositories/doctor_appointment_repository_impl.dart'
    as _i408;
import '../../features/reservation/data/repositories/reservation_repository_impl.dart'
    as _i264;
import '../../features/reservation/data/repositories/schedule_repository.dart'
    as _i699;
import '../../features/reservation/data/repositories/schedule_repository_impl.dart'
    as _i392;
import '../../features/reservation/domain/repository/reservation_repository.dart'
    as _i771;
import '../../features/reservation/domain/use_cases/add_update_schedule_use_case.dart'
    as _i410;
import '../../features/reservation/domain/use_cases/create_reservation_usecase.dart'
    as _i843;
import '../../features/reservation/presentation/view_model/add_update_schedule_cubit.dart'
    as _i63;
import '../../features/reservation/presentation/view_model/doctor_appointment_cubit.dart'
    as _i344;
import '../../features/reservation/presentation/view_model/schedule_cubit.dart'
    as _i135;
import '../../features/search/data/search_service.dart' as _i506;
import '../../features/search/presentation/view_model/search_cubit.dart'
    as _i794;
import '../../features/user_appointment/data/data_source/all_doctors_data_source/all_doctors_data_source.dart'
    as _i1040;
import '../../features/user_appointment/data/data_source/available_slot_data_source/available_slot_data_source.dart'
    as _i394;
import '../../features/user_appointment/data/repository/all_doctor_repo_impl.dart'
    as _i596;
import '../../features/user_appointment/data/repository/available_slots_repository_impl.dart'
    as _i957;
import '../../features/user_appointment/data/repository/user_appointment_repository_impl.dart'
    as _i990;
import '../../features/user_appointment/domain/repository/available_slot_repository.dart'
    as _i402;
import '../../features/user_appointment/domain/repository/user_appointmet_repository.dart'
    as _i985;
import '../../features/user_appointment/domain/use_cases/get_available_slots_use_case.dart'
    as _i753;
import '../../features/user_appointment/domain/use_cases/get_user_appointment_use_case.dart'
    as _i363;
import '../../features/user_appointment/presentation/view_model/available_slots_cubit.dart'
    as _i987;
import '../../features/user_appointment/presentation/view_model/make_reservation_cubit.dart'
    as _i1049;
import '../../features/user_appointment/presentation/view_model/user_appointment_cubit.dart'
    as _i624;
import '../../features/user_profile/data/repository/user_profile_repository_impl.dart'
    as _i638;
import '../../features/user_profile/domain/repository/user_profile_repository.dart'
    as _i544;
import '../../features/user_profile/domain/use_cases/user/log_out_use_case.dart'
    as _i115;
import '../../features/user_profile/domain/use_cases/user/user_profile_usecase.dart'
    as _i1000;
import '../../features/user_profile/presentation/view_model/user_profile_cubit.dart'
    as _i631;
import '../network/api_client.dart' as _i557;
import '../network/network_module.dart' as _i200;
import '../utils/shared_prefs.dart' as _i397;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => networkModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i397.SharedPrefs>(
      () => _i397.SharedPrefs(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i557.ApiClientPrediction>(
      () => networkModule.apiClientPrediction(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i557.ApiClient>(
      () => networkModule.apiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i557.ReadPerceptionClint>(
      () => networkModule.prescriptionClient(gh<_i361.Dio>()),
    );
    gh.factory<_i408.DoctorAppointmentRepository>(
      () => _i408.DoctorAppointmentRepositoryImpl(
        gh<_i557.ApiClient>(),
        gh<_i397.SharedPrefs>(),
      ),
    );
    gh.factory<_i1008.ChatRepository>(
      () => _i257.ChatRepositoryImpl(
        gh<_i557.ApiClient>(),
        gh<_i397.SharedPrefs>(),
      ),
    );
    gh.lazySingleton<_i280.AuthLocalDataSource>(
      () => _i280.AuthLocalDataSourceImpl(gh<_i397.SharedPrefs>()),
    );
    gh.factory<_i771.ReservationRepository>(
      () => _i264.ReservationRepositoryImpl(
        gh<_i397.SharedPrefs>(),
        gh<_i557.ApiClient>(),
      ),
    );
    gh.factory<_i913.PrescriptionRepository>(
      () => _i582.PrescriptionRepositoryImpl(gh<_i557.ReadPerceptionClint>()),
    );
    gh.lazySingleton<_i544.UserRepository>(
      () => _i638.UserRepositoryImpl(
        gh<_i557.ApiClient>(),
        gh<_i397.SharedPrefs>(),
      ),
    );
    gh.lazySingleton<_i352.PredictionDataSource>(
      () => _i352.PredictionDataSourceImpl(gh<_i557.ApiClientPrediction>()),
    );
    gh.factory<_i440.UpdateUserProfileRepository>(
      () => _i440.UpdateUserProfileRepositoryImpl(
        gh<_i557.ApiClient>(),
        gh<_i397.SharedPrefs>(),
      ),
    );
    gh.factory<_i631.UserProfileCubit>(
      () => _i631.UserProfileCubit(gh<_i544.UserRepository>()),
    );
    gh.lazySingleton<_i478.DoctorProfileRepository>(
      () => _i289.DoctorProfileRepositoryImpl(
        gh<_i557.ApiClient>(),
        gh<_i397.SharedPrefs>(),
      ),
    );
    gh.lazySingleton<_i444.GetUserProfile>(
      () => _i444.GetUserProfile(gh<_i478.DoctorProfileRepository>()),
    );
    gh.factory<_i985.UserAppointmentRepository>(
      () => _i990.UserAppointmentRepositoryImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i456.AuthRemoteDataSource>(
      () => _i456.AuthRemoteDataSourceImpl(apiClient: gh<_i557.ApiClient>()),
    );
    gh.factory<_i557.DeleteChatUseCase>(
      () => _i557.DeleteChatUseCase(gh<_i1008.ChatRepository>()),
    );
    gh.factory<_i11.FetchChatHistoryUseCase>(
      () => _i11.FetchChatHistoryUseCase(gh<_i1008.ChatRepository>()),
    );
    gh.factory<_i546.SendMessageUseCase>(
      () => _i546.SendMessageUseCase(gh<_i1008.ChatRepository>()),
    );
    gh.lazySingleton<_i1040.DoctorDataSource>(
      () => _i1040.DoctorDataSource(apiManager: gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i394.AvailableSlotDataSource>(
      () => _i394.AvailableSlotDataSource(apiManager: gh<_i557.ApiClient>()),
    );
    gh.factory<_i344.DoctorAppointmentCubit>(
      () =>
          _i344.DoctorAppointmentCubit(gh<_i408.DoctorAppointmentRepository>()),
    );
    gh.factory<_i36.ChatCubit>(
      () => _i36.ChatCubit(
        fetchChatHistory: gh<_i11.FetchChatHistoryUseCase>(),
        sendMessage: gh<_i546.SendMessageUseCase>(),
        deleteChat: gh<_i557.DeleteChatUseCase>(),
      ),
    );
    gh.factory<_i529.PredictionRepository>(
      () => _i60.PredictionRepoImpl(gh<_i352.PredictionDataSource>()),
    );
    gh.singleton<_i363.GetUserAppointmentsUseCase>(
      () => _i363.GetUserAppointmentsUseCase(
        gh<_i985.UserAppointmentRepository>(),
      ),
    );
    gh.factory<_i699.ScheduleRepository>(
      () => _i392.ScheduleRepositoryImpl(
        gh<_i557.ApiClient>(),
        gh<_i397.SharedPrefs>(),
      ),
    );
    gh.lazySingleton<_i727.DrugInteractionsRemoteDataSource>(
      () => _i727.DrugInteractionsRemoteDataSource(
        apiClient: gh<_i557.ApiClient>(),
      ),
    );
    gh.lazySingleton<_i865.PrescriptionUseCase>(
      () => _i865.PrescriptionUseCase(gh<_i913.PrescriptionRepository>()),
    );
    gh.factory<_i135.ScheduleCubit>(
      () => _i135.ScheduleCubit(gh<_i699.ScheduleRepository>()),
    );
    gh.factory<_i1051.PrescriptionCubit>(
      () => _i1051.PrescriptionCubit(gh<_i865.PrescriptionUseCase>()),
    );
    gh.lazySingleton<_i410.AddUpdateScheduleUseCase>(
      () => _i410.AddUpdateScheduleUseCase(gh<_i771.ReservationRepository>()),
    );
    gh.lazySingleton<_i843.CreateReservationUsecase>(
      () => _i843.CreateReservationUsecase(gh<_i771.ReservationRepository>()),
    );
    gh.singleton<_i401.UpdateUserProfileUseCase>(
      () => _i401.UpdateUserProfileUseCase(
        gh<_i440.UpdateUserProfileRepository>(),
      ),
    );
    gh.factory<_i63.ScheduleCubit>(
      () => _i63.ScheduleCubit(gh<_i410.AddUpdateScheduleUseCase>()),
    );
    gh.lazySingleton<_i961.AuthRepository>(
      () => _i409.AuthRepositoryImpl(
        gh<_i460.SharedPreferences>(),
        gh<_i397.SharedPrefs>(),
        remoteDataSource: gh<_i456.AuthRemoteDataSource>(),
        localDataSource: gh<_i280.AuthLocalDataSource>(),
        apiClient: gh<_i557.ApiClient>(),
      ),
    );
    gh.lazySingleton<_i115.GetUserProfile>(
      () => _i115.GetUserProfile(gh<_i544.UserRepository>()),
    );
    gh.lazySingleton<_i1000.GetUserProfile>(
      () => _i1000.GetUserProfile(gh<_i544.UserRepository>()),
    );
    gh.factory<_i729.DrugInteractionsRepository>(
      () => _i33.DrugInteractionsRepositoryImpl(
        remoteDataSource: gh<_i727.DrugInteractionsRemoteDataSource>(),
      ),
    );
    gh.singleton<_i402.AvailableSlotsRepository>(
      () => _i957.AvailableSlotsRepositoryImpl(
        gh<_i394.AvailableSlotDataSource>(),
      ),
    );
    gh.factory<_i64.DoctorProfileCubit>(
      () => _i64.DoctorProfileCubit(
        gh<_i478.DoctorProfileRepository>(),
        gh<_i397.SharedPrefs>(),
      ),
    );
    gh.factory<_i584.UpdateUserProfileCubit>(
      () => _i584.UpdateUserProfileCubit(gh<_i401.UpdateUserProfileUseCase>()),
    );
    gh.factory<_i771.ChangePasswordUsecase>(
      () => _i771.ChangePasswordUsecase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i596.DoctorRepository>(
      () => _i596.DoctorRepository(
        doctorDataSource: gh<_i1040.DoctorDataSource>(),
      ),
    );
    gh.lazySingleton<_i640.PredictionUseCase>(
      () => _i640.PredictionUseCase(gh<_i529.PredictionRepository>()),
    );
    gh.factory<_i624.UserAppointmentCubit>(
      () => _i624.UserAppointmentCubit(gh<_i363.GetUserAppointmentsUseCase>()),
    );
    gh.lazySingleton<_i1049.CreateReservationCubit>(
      () => _i1049.CreateReservationCubit(gh<_i843.CreateReservationUsecase>()),
    );
    gh.lazySingleton<_i957.LogInUseCase>(
      () => _i957.LogInUseCase(gh<_i961.AuthRepository>()),
    );
    gh.lazySingleton<_i571.SignupUseCase>(
      () => _i571.SignupUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i753.GetAvailableSlotsUseCase>(
      () =>
          _i753.GetAvailableSlotsUseCase(gh<_i402.AvailableSlotsRepository>()),
    );
    gh.factory<_i917.DrugInteractionsUseCase>(
      () => _i917.DrugInteractionsUseCase(
        repository: gh<_i729.DrugInteractionsRepository>(),
      ),
    );
    gh.factory<_i506.SearchService>(
      () => _i506.SearchService(gh<_i596.DoctorRepository>()),
    );
    gh.factory<_i472.ChangePasswordCubit>(
      () => _i472.ChangePasswordCubit(gh<_i771.ChangePasswordUsecase>()),
    );
    gh.factory<_i208.AuthCubit>(
      () => _i208.AuthCubit(
        gh<_i957.LogInUseCase>(),
        gh<_i571.SignupUseCase>(),
        gh<_i280.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i501.PredictionCubit>(
      () => _i501.PredictionCubit(
        predictionUseCase: gh<_i640.PredictionUseCase>(),
        prefs: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i794.SearchCubit>(
      () => _i794.SearchCubit(gh<_i506.SearchService>()),
    );
    gh.factory<_i525.CheckDrugInteractionCubit>(
      () =>
          _i525.CheckDrugInteractionCubit(gh<_i917.DrugInteractionsUseCase>()),
    );
    gh.factory<_i607.DiseaseDrugInteractionCubit>(
      () => _i607.DiseaseDrugInteractionCubit(
        gh<_i917.DrugInteractionsUseCase>(),
      ),
    );
    gh.factory<_i994.DrugSubstitutionsCubit>(
      () => _i994.DrugSubstitutionsCubit(gh<_i917.DrugInteractionsUseCase>()),
    );
    gh.factory<_i987.AvailableSlotsCubit>(
      () => _i987.AvailableSlotsCubit(gh<_i753.GetAvailableSlotsUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
