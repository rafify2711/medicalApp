import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';
import '../theme/theme_provider.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void>  configureDependencies() async{
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  await getIt.init();
}

