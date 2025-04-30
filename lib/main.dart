import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/di/di.config.dart';
import 'core/config/route_generator.dart';
import 'core/config/route_names.dart';
import 'core/di/di.dart';
import 'features/medical_dignosis/presentation/view_model/prediction_cubit.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await getIt.init();

  configureDependencies();
  runApp( const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
        providers: [
        BlocProvider<PredictionCubit>(create: (context) => getIt<PredictionCubit>()), // توفير PredictionCubit

    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: RouteNames.splash,
      ),
    );
  }
}
