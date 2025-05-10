import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_medical_app/core/di/di.config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config/route_generator.dart';
import 'core/config/route_names.dart';
import 'core/di/di.dart';
import 'features/medical_dignosis/presentation/view_model/prediction_cubit.dart';
import 'core/localization/app_localizations.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await getIt.init();

  configureDependencies();
  runApp( const MyApp(),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language');
    if (savedLanguage != null) {
      setState(() {
        _locale = Locale(savedLanguage);
      });
    }
  }

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
        locale: _locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'), // Arabic
        ],
      ),
    );
  }
}
