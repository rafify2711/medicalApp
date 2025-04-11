import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/di/di.config.dart';
import 'core/config/route_generator.dart';
import 'core/config/route_names.dart';
import 'core/di/di.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await getIt.init();

  configureDependencies();
  runApp( const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteNames.login,
    );
  }
}
