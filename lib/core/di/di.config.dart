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
    gh.lazySingleton<_i456.AuthRemoteDataSource>(
      () => _i456.AuthRemoteDataSourceImpl(apiClient: gh<_i557.ApiClient>()),
    );
    gh.factory<_i529.PredictionRepository>(
      () => _i60.PredictionRepoImpl(gh<_i352.PredictionDataSource>()),
    );
    gh.lazySingleton<_i575.GetUserProfile>(
      () => _i575.GetUserProfile(gh<_i237.UserRepository>()),
    );
    gh.factory<_i396.UserProfileCubit>(
      () => _i396.UserProfileCubit(gh<_i237.UserRepository>()),
    );
    gh.lazySingleton<_i961.AuthRepository>(
      () => _i409.AuthRepositoryImpl(
        gh<_i460.SharedPreferences>(),
        remoteDataSource: gh<_i456.AuthRemoteDataSource>(),
        localDataSource: gh<_i280.AuthLocalDataSource>(),
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
    gh.factory<_i501.PredictionCubit>(
      () => _i501.PredictionCubit(gh<_i640.PredictionUseCase>()),
    );
    gh.factory<_i208.AuthCubit>(
      () =>
          _i208.AuthCubit(gh<_i957.LogInUseCase>(), gh<_i571.SignupUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
