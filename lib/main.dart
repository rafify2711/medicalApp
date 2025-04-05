import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/screens/log_in_screen.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:graduation_medical_app/features/chat_bot/presentation/view/chatbot_screen.dart';
import 'package:graduation_medical_app/features/medical_dignosis/presentation/view/disease_prediction_list_screen.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view/add_doctor_scadule.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_appointment_screen.dart';
import 'package:graduation_medical_app/features/user_home/presentation/view/user_home_screen.dart';

import 'core/di/di.dart';
import 'core/utils/shared_prefs.dart';
import 'features/Profile/presentation/view/user_profile_screen.dart';
import 'features/Profile/presentation/view_model/user_profile_cubit.dart';
import 'features/auth/presentation/view_model/auth_cubit.dart';
import 'features/doctor_home/presentation/doctor_home_screen.dart';
import 'features/layout/presentation/lay_out.dart';
import 'features/medical_dignosis/presentation/view/prediction_screen.dart';
import 'features/medical_dignosis/presentation/view_model/prediction_cubit.dart';
import 'features/user_appointment/presentation/view/user_doctors_screen/doctors_list_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
        BlocProvider<PredictionCubit>(create: (context) => getIt<PredictionCubit>()),
        BlocProvider<UserProfileCubit>(create: (context) => getIt<UserProfileCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignUpScreen.routeName: (_) => SignUpScreen(),
        LogInScreen.routeName: (_) => LogInScreen(),
        DoctorHomeScreen.routeName: (_) => DoctorHomeScreen(),
        PredictionScreen.routeName: (_) => PredictionScreen(disease: ''),
        DiseasePredictionListScreen.routeName: (_) => DiseasePredictionListScreen(),
        UserProfileScreen.routeName: (_) => UserProfileScreen(token: '',userId: '',),
        UserHomeScreen.routeName:(_) => UserHomeScreen(),
        ChatbotScreen.routeName:(_) => ChatbotScreen(),
        UserAppointmentScreen.routeName:(_) => UserAppointmentScreen(),
        DoctorScheduleScreen.routeName:(_)=> DoctorScheduleScreen(),
        DoctorListScreen.routeName:(_)=> DoctorListScreen(),
      },
      home:UserHomeScreen(),
    );
  }
}
