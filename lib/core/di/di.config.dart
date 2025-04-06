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
import '../../features/auth/domain/use_cases/log_in_use_case.dart' as _i957;
import '../../features/auth/domain/use_cases/signup_use_case.dart' as _i571;
import '../../features/auth/presentation/view_model/auth_cubit.dart' as _i208;
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
import '../../features/Profile/data/repository/user_profile_repository_impl.dart'
    as _i195;
import '../../features/Profile/domain/repository/user_profile_repository.dart'
    as _i237;
import '../../features/Profile/domain/use_cases/user/user_profile_usecase.dart'
    as _i575;
import '../../features/Profile/presentation/view_model/user_profile_cubit.dart'
    as _i396;
import '../../features/user_appointment/data/data_source/all_doctors_data_source/all_doctors_data_source.dart'
    as _i1040;
import '../../features/user_appointment/data/repository/all_doctor_repo_impl.dart'
    as _i596;
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
    gh.lazySingleton<_i280.AuthLocalDataSource>(
      () => _i280.AuthLocalDataSourceImpl(gh<_i397.SharedPrefs>()),
    );
    gh.lazySingleton<_i237.UserRepository>(
      () => _i195.UserRepositoryImpl(
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
    gh.lazySingleton<_i456.AuthRemoteDataSource>(
      () => _i456.AuthRemoteDataSourceImpl(apiClient: gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i1040.DoctorDataSource>(
      () => _i1040.DoctorDataSource(apiManager: gh<_i557.ApiClient>()),
    );
    gh.factory<_i529.PredictionRepository>(
      () => _i60.PredictionRepoImpl(gh<_i352.PredictionDataSource>()),
    );
    gh.lazySingleton<_i727.DrugInteractionsRemoteDataSource>(
      () => _i727.DrugInteractionsRemoteDataSource(
        apiClient: gh<_i557.ApiClient>(),
      ),
    );
    gh.lazySingleton<_i575.GetUserProfile>(
      () => _i575.GetUserProfile(gh<_i237.UserRepository>()),
    );
    gh.singleton<_i401.UpdateUserProfileUseCase>(
      () => _i401.UpdateUserProfileUseCase(
        gh<_i440.UpdateUserProfileRepository>(),
      ),
    );
    gh.factory<_i396.UserProfileCubit>(
      () => _i396.UserProfileCubit(gh<_i237.UserRepository>()),
    );
    gh.factory<_i729.DrugInteractionsRepository>(
      () => _i33.DrugInteractionsRepositoryImpl(
        remoteDataSource: gh<_i727.DrugInteractionsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i961.AuthRepository>(
      () => _i409.AuthRepositoryImpl(
        gh<_i460.SharedPreferences>(),
        remoteDataSource: gh<_i456.AuthRemoteDataSource>(),
        localDataSource: gh<_i280.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i584.UpdateUserProfileCubit>(
      () => _i584.UpdateUserProfileCubit(gh<_i401.UpdateUserProfileUseCase>()),
    );
    gh.factory<_i596.DoctorRepository>(
      () => _i596.DoctorRepository(
        doctorDataSource: gh<_i1040.DoctorDataSource>(),
      ),
    );
    gh.lazySingleton<_i640.PredictionUseCase>(
      () => _i640.PredictionUseCase(gh<_i529.PredictionRepository>()),
    );
    gh.lazySingleton<_i957.LogInUseCase>(
      () => _i957.LogInUseCase(gh<_i961.AuthRepository>()),
    );
    gh.lazySingleton<_i571.SignupUseCase>(
      () => _i571.SignupUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i917.DrugInteractionsUseCase>(
      () => _i917.DrugInteractionsUseCase(
        repository: gh<_i729.DrugInteractionsRepository>(),
      ),
    );
    gh.factory<_i501.PredictionCubit>(
      () => _i501.PredictionCubit(gh<_i640.PredictionUseCase>()),
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
    gh.factory<_i208.AuthCubit>(
      () =>
          _i208.AuthCubit(gh<_i957.LogInUseCase>(), gh<_i571.SignupUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
