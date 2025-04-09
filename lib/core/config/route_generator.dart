import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/di/di.dart';

import '../../features/auth/presentation/view/screens/log_in_screen.dart';
import '../../features/auth/presentation/view/screens/sign_up_screen.dart';
import '../../features/chat_bot/presentation/view/chatbot_screen.dart';
import '../../features/doctor_home/presentation/doctor_home_screen.dart';
import '../../features/doctor_profile/presentation/view/doctor_screen.dart';
import '../../features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart';
import '../../features/layout/presentation/doctor_lay_out.dart';
import '../../features/layout/presentation/lay_out.dart';
import '../../features/medical_dignosis/presentation/view/disease_prediction_list_screen.dart';
import '../../features/medical_dignosis/presentation/view/prediction_screen.dart';
import '../../features/medical_dignosis/presentation/view_model/prediction_cubit.dart';
import '../../features/user_appointment/presentation/view/user_appointment_screen.dart';
import '../../features/user_home/presentation/view/user_home_screen.dart';
import '../../features/user_profile/presentation/view/profile_screen.dart';
import '../../features/user_profile/presentation/view_model/user_profile_cubit.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (_) => SignUpScreen());
    case LogInScreen.routeName:
      return MaterialPageRoute(builder: (_) => LogInScreen());
    case DoctorHomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => DoctorHomeScreen());
    case PredictionScreen.routeName:
      final args = settings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => BlocProvider<PredictionCubit>(
            create: (_) => getIt<PredictionCubit>(),
            child: PredictionScreen(disease: args),
          ));
    case DiseasePredictionListScreen.routeName:
      return MaterialPageRoute(builder: (_) => DiseasePredictionListScreen());
    case UserHomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => UserHomeScreen());
    case ChatbotScreen.routeName:
      return MaterialPageRoute(builder: (_) => ChatbotScreen());
    case UserAppointmentScreen.routeName:
      return MaterialPageRoute(builder: (_) => UserAppointmentScreen());
    case DoctorProfileScreen.routeName:
      final args = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => BlocProvider<DoctorProfileCubit>(
          create: (_) => getIt<DoctorProfileCubit>(),
          child: DoctorProfileScreen(userId: args),
        ),
      );
    case ProfileScreen.routeName:
      final args = settings.arguments as Map<String, String>;
      return MaterialPageRoute(
        builder: (_) => BlocProvider<UserProfileCubit>(
          create: (_) => getIt<UserProfileCubit>(),
          child: ProfileScreen(token: args['token']!, userId: args['userId']!),
        ),
      );
    case DoctorLayOut.routeName:
      return MaterialPageRoute(builder: (_) => DoctorLayOut());
    case UserLayOut.routeName:
      return MaterialPageRoute(builder: (_) => UserLayOut());
  // You can add more routes here
    default:
      return MaterialPageRoute(builder: (_) => Scaffold(body: Text('Error routing'),));
  }
}
