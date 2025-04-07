import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/screens/log_in_screen.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:graduation_medical_app/features/chat_bot/presentation/view/chatbot_screen.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart';
import 'package:graduation_medical_app/features/drug_conflict/presentation/view/check_drug_interaction_screen.dart';
import 'package:graduation_medical_app/features/drug_conflict/presentation/view/disease_drug_interaction_screen.dart';
import 'package:graduation_medical_app/features/drug_conflict/presentation/view/drug_subsitiutions_screen.dart';
import 'package:graduation_medical_app/features/drug_conflict/presentation/view/drug_tabs.dart';
import 'package:graduation_medical_app/features/drug_conflict/presentation/view_model/check_drug_interaction_cubit.dart';
import 'package:graduation_medical_app/features/drug_conflict/presentation/view_model/disease_drug_interaction_cubit.dart';
import 'package:graduation_medical_app/features/drug_conflict/presentation/view_model/drug_substitutions_cubit.dart';
import 'package:graduation_medical_app/features/edit_profile/presentation/view/update_user_profile_screen.dart';
import 'package:graduation_medical_app/features/edit_profile/presentation/view_model/update_user_Profile_cubit.dart';
import 'package:graduation_medical_app/features/medical_dignosis/presentation/view/disease_prediction_list_screen.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view/add_doctor_scadule.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/available_slots_screen.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_appointment_screen.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view_model/available_slots_cubit.dart';
import 'package:graduation_medical_app/features/user_home/presentation/view/user_home_screen.dart';

import 'core/di/di.dart';
import 'core/utils/shared_prefs.dart';
import 'features/auth/presentation/view_model/auth_cubit.dart';
import 'features/doctor_home/presentation/doctor_home_screen.dart';
import 'features/doctor_profile/presentation/view/doctor_screen.dart';
import 'features/layout/presentation/doctor_lay_out.dart';
import 'features/layout/presentation/lay_out.dart';
import 'features/medical_dignosis/presentation/view/prediction_screen.dart';
import 'features/medical_dignosis/presentation/view_model/prediction_cubit.dart';
import 'features/user_appointment/presentation/view/user_doctors_screen/doctors_list_screen.dart';
import 'features/user_appointment/presentation/view_model/user_appointment_cubit.dart';
import 'features/user_profile/presentation/view/profile_screen.dart';
import 'features/user_profile/presentation/view_model/user_profile_cubit.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
    BlocProvider<UserAppointmentCubit>(create: (context)=>getIt<UserAppointmentCubit>()),
        BlocProvider<UpdateUserProfileCubit>(create: (context)=>getIt<UpdateUserProfileCubit>()),
        BlocProvider<CheckDrugInteractionCubit>(create: (context) => getIt<CheckDrugInteractionCubit>(),),
        BlocProvider<DiseaseDrugInteractionCubit>(create: (context) => getIt<DiseaseDrugInteractionCubit>(),),
        BlocProvider<DrugSubstitutionsCubit>(create: (context) => getIt<DrugSubstitutionsCubit>(),),
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
        BlocProvider<PredictionCubit>(create: (context) => getIt<PredictionCubit>()),
        BlocProvider<UserProfileCubit>(create: (context) => getIt<UserProfileCubit>()),
        BlocProvider<AvailableSlotsCubit>(create: (context) => getIt<AvailableSlotsCubit>()),
        BlocProvider<DoctorProfileCubit>(create: (context) => getIt<DoctorProfileCubit>()),
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
        UserHomeScreen.routeName:(_) => UserHomeScreen(),
        ChatbotScreen.routeName:(_) => ChatbotScreen(),
        UserAppointmentScreen.routeName:(_) => UserAppointmentScreen(),
        DoctorScheduleScreen.routeName:(_)=> DoctorScheduleScreen(),
        DoctorListScreen.routeName:(_)=> DoctorListScreen(),
        CheckDrugInteractionScreen.routeName:(_)=> CheckDrugInteractionScreen(),
        DiseaseDrugInteractionScreen.routeName:(_)=> DiseaseDrugInteractionScreen(),
        DrugSubstitutionScreen.routeName:(_)=> DrugSubstitutionScreen(),
        DrugTabsScreen.routeName:(_)=> DrugTabsScreen(),
        UpdateProfileScreen.routeName:(_)=>UpdateProfileScreen(),
        ProfileScreen.routeName:(_)=>ProfileScreen(token: '', userId: ''),
        UserLayOut.routeName:(_)=>UserLayOut(),
        DoctorProfileScreen.routeName:(_)=>DoctorProfileScreen(userId: '',),
        AvailableSlotsScreen.routeName:(_)=>AvailableSlotsScreen(selectedDate: DateTime.now(), userId:'' ),
        DoctorLayOut.routeName:(_)=>DoctorLayOut(),
      },
      home:LogInScreen(),
    );
  }
}
