import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_medical_app/core/di/di.config.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view_model/doctor_appointment_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config/route_generator.dart';
import 'core/config/route_names.dart';
import 'core/di/di.dart';
import 'features/medical_dignosis/presentation/view_model/prediction_cubit.dart';
import 'core/localization/app_localizations.dart';
import 'features/reservation/presentation/view_model/add_update_schedule_cubit.dart';
import 'features/user_appointment/presentation/view_model/make_reservation_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await getIt.init();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<_MyAppState> appStateKey = GlobalKey<_MyAppState>();

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

  void changeLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PredictionCubit>(create: (context) => getIt<PredictionCubit>()),
        BlocProvider(create: (context) => getIt<ScheduleCubit>()),
        BlocProvider(create: (context) => getIt<DoctorAppointmentCubit>()),
        BlocProvider(create: (context) => getIt<CreateReservationCubit>()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            key: MyApp.appStateKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: RouteNames.splash,
            locale: _locale,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
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
          );
        },
      ),
    );
  }
}
