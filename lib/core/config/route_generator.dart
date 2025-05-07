import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/features/edit_profile/presentation/view_model/update_user_Profile_cubit.dart';
import 'package:graduation_medical_app/features/hospitals_and_pharmacies/presentation/view/hospitals_screen.dart';
import 'package:graduation_medical_app/features/hospitals_and_pharmacies/presentation/view/pharmacies_screen.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view_model/add_update_schedule_cubit.dart';
import 'package:graduation_medical_app/features/search/presentation/view_model/search_cubit.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view_model/available_slots_cubit.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view_model/make_reservation_cubit.dart';
import '../../features/auth/presentation/view/screens/log_in_screen.dart';
import '../../features/auth/presentation/view/screens/sign_up_screen.dart';
import '../../features/auth/presentation/view_model/auth_cubit.dart';
import '../../features/chat_bot/presentation/view/chatbot_screen.dart';
import '../../features/chat_bot/presentation/view_model/chat_cubit.dart';
import '../../features/doctor_home/presentation/doctor_home_screen.dart';
import '../../features/doctor_profile/presentation/view/doctor_profile_screen.dart';
import '../../features/doctor_profile/presentation/view/edit_doctor_profile_screen.dart';
import '../../features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart';
import '../../features/drug_conflict/presentation/view/check_drug_interaction_screen.dart';
import '../../features/drug_conflict/presentation/view/disease_drug_interaction_screen.dart';
import '../../features/drug_conflict/presentation/view/drug_subsitiutions_screen.dart';
import '../../features/drug_conflict/presentation/view/drug_tabs.dart';
import '../../features/drug_conflict/presentation/view_model/check_drug_interaction_cubit.dart';
import '../../features/drug_conflict/presentation/view_model/disease_drug_interaction_cubit.dart';
import '../../features/drug_conflict/presentation/view_model/drug_substitutions_cubit.dart';
import '../../features/edit_profile/presentation/view/update_user_profile_screen.dart';
import '../../features/layout/presentation/doctor_lay_out.dart';
import '../../features/layout/presentation/lay_out.dart';
import '../../features/medical_dignosis/presentation/view/disease_prediction_list_screen.dart';
import '../../features/medical_dignosis/presentation/view/prediction_screen.dart';
import '../../features/medical_dignosis/presentation/view_model/prediction_cubit.dart';
import '../../features/prescription/presentation/view/read_prescription_screen.dart';
import '../../features/prescription/presentation/view_model/prescription_cubit.dart';
import '../../features/reservation/presentation/view/add_doctor_scadule.dart';
import '../../features/search/presentation/view/global_search_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/splash/welcome_screen.dart';
import '../../features/user_appointment/data/models/doctor_model/doctor_model.dart';
import '../../features/user_appointment/presentation/view/available_slots_screen.dart';
import '../../features/user_appointment/presentation/view/user_appointment_screen.dart';
import '../../features/user_appointment/presentation/view/user_doctors_screen/doctors_list_screen.dart';
import '../../features/user_appointment/presentation/view/user_doctors_screen/make_reservation_screen.dart';
import '../../features/user_appointment/presentation/view/user_doctors_screen/user_doctors_screen.dart';
import '../../features/user_appointment/presentation/view_model/user_appointment_cubit.dart';
import '../../features/user_home/presentation/view/user_home_screen.dart';
import '../../features/user_profile/presentation/view/profile_screen.dart';
import '../../features/user_profile/presentation/view_model/user_profile_cubit.dart';
import '../di/di.dart';
import '../models/doctor_model/doctor_model.dart';
import '../../features/reservation/presentation/view/view_schedule_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.signUp:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<AuthCubit>(
                create: (context) => getIt<AuthCubit>(),
                child: SignUpScreen(),
              ),
        );

      case RouteNames.login:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<AuthCubit>(
                create: (context) => getIt<AuthCubit>(),
                child: LogInScreen(),
              ),
        );

      case RouteNames.doctorHome:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<DoctorProfileCubit>(
                    create: (context) => getIt<DoctorProfileCubit>(),
                  ),
                  BlocProvider<UserAppointmentCubit>(
                    create: (context) => getIt<UserAppointmentCubit>(),
                  ),
                  BlocProvider<PredictionCubit>(
                    create: (context) => getIt<PredictionCubit>(),
                  ),
                ],
                child: DoctorHomeScreen(),
              ),
        );

      case RouteNames.prediction:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<PredictionCubit>(
                create: (context) => getIt<PredictionCubit>(),
                child: PredictionScreen(disease: args['disease']),
              ),
        );

      case RouteNames.diseasePredictionList:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<PredictionCubit>(
                create: (context) => getIt<PredictionCubit>(),
                child: DiseasePredictionListScreen(),
              ),
        );

      case RouteNames.userHome:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<UserProfileCubit>(
                    create: (context) => getIt<UserProfileCubit>(),
                  ),
                  BlocProvider<UserAppointmentCubit>(
                    create: (context) => getIt<UserAppointmentCubit>(),
                  ),
                  BlocProvider<PredictionCubit>(
                    create: (context) => getIt<PredictionCubit>(),
                  ),
                ],
                child: UserHomeScreen(),
              ),
        );

      case RouteNames.chatbot:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<ChatCubit>(
                create: (context) => getIt<ChatCubit>(),
                child: ChatbotScreen(),
              ),
        );

      case RouteNames.userAppointment:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<UserAppointmentCubit>(
                create: (context) => getIt<UserAppointmentCubit>(),
                child: UserAppointmentScreen(),
              ),
        );

      case RouteNames.doctorSchedule:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<ScheduleCubit>(
                create: (context) => getIt<ScheduleCubit>(),
                child: DoctorScheduleScreen(),
              ),
        );

      case RouteNames.doctorDetails:
        final doctor = settings.arguments as DoctorsModel;
        return MaterialPageRoute(
          builder: (_) => DoctorDetailsScreen(doctor: doctor),
        );

      case RouteNames.doctorList:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<ScheduleCubit>(
                create: (context) => getIt<ScheduleCubit>(),
                child: DoctorListScreen(),
              ),
        );

      case RouteNames.checkDrugInteraction:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<CheckDrugInteractionCubit>(
                create: (context) => getIt<CheckDrugInteractionCubit>(),
                child: CheckDrugInteractionScreen(),
              ),
        );

      case RouteNames.diseaseDrugInteraction:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<DiseaseDrugInteractionCubit>(
                create: (context) => getIt<DiseaseDrugInteractionCubit>(),
                child: DiseaseDrugInteractionScreen(),
              ),
        );

      case RouteNames.drugSubstitution:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<DrugSubstitutionsCubit>(
                create: (context) => getIt<DrugSubstitutionsCubit>(),
                child: DrugSubstitutionScreen(),
              ),
        );

      case RouteNames.drugTabs:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<DrugSubstitutionsCubit>(
                    create: (context) => getIt<DrugSubstitutionsCubit>(),
                  ),
                  BlocProvider<DiseaseDrugInteractionCubit>(
                    create: (context) => getIt<DiseaseDrugInteractionCubit>(),
                  ),
                  BlocProvider<CheckDrugInteractionCubit>(
                    create: (context) => getIt<CheckDrugInteractionCubit>(),
                  ),
                ],
                child: DrugTabsScreen(),
              ),
        );

      case RouteNames.updateProfile:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<UpdateUserProfileCubit>(
                create: (context) => getIt<UpdateUserProfileCubit>(),
                child: UpdateProfileScreen(),
              ),
          settings: settings,
        );

      case RouteNames.profile:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<UserProfileCubit>(
                create: (context) => getIt<UserProfileCubit>(),
                child: ProfileScreen(
                  token: args['token'],
                  userId: args['userId'],
                ),
              ),
        );

      case RouteNames.userLayout:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<UserProfileCubit>(
                    create: (context) => getIt<UserProfileCubit>(),
                  ),
                  BlocProvider<UserAppointmentCubit>(
                    create: (context) => getIt<UserAppointmentCubit>(),
                  ),
                ],
                child: UserLayOut(),
              ),
        );

      case RouteNames.doctorProfile:
        final userId = settings.arguments as String;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<DoctorProfileCubit>(
                create: (context) => getIt<DoctorProfileCubit>(),
                child: DoctorProfileScreen(userId: userId),
              ),
        );

      case RouteNames.editDoctorProfile:
        final profile = settings.arguments as DoctorModel;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<DoctorProfileCubit>(
                create: (context) => getIt<DoctorProfileCubit>(),
                child: EditDoctorProfileScreen(profile: profile),
              ),
        );

      case RouteNames.availableSlots:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => AvailableSlotsScreen(
                selectedDate: args['selectedDate'],
                userId: args['userId'],
              ),
        );

      case RouteNames.doctorLayout:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<DoctorProfileCubit>(
                    create: (context) => getIt<DoctorProfileCubit>(),
                  ),
                  BlocProvider<ScheduleCubit>(
                    create: (context) => getIt<ScheduleCubit>(),
                  ),
                ],
                child: DoctorLayOut(),
              ),
        );

      case RouteNames.readPrescription:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<PrescriptionCubit>(
                create: (context) => getIt<PrescriptionCubit>(),
                child: ReadPrescriptionScreen(),
              ),
        );

      case RouteNames.makeReservation:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AvailableSlotsCubit>(
                create: (context) => getIt<AvailableSlotsCubit>(),
              ),
              BlocProvider<CreateReservationCubit>(
                create: (context) => getIt<CreateReservationCubit>(),
              ),
            ],
            child: MakeReservationScreen(
              doctorId: args['doctorId'],
              selectedDate: args['selectedDate'],
            ),
          ),
        );

      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case RouteNames.welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());

      case RouteNames.hospital:
        return MaterialPageRoute(builder: (_) => HospitalScreen());

      case RouteNames.pharmacy:
        return MaterialPageRoute(builder: (_) => PharmacyListScreen());

      case RouteNames.globalSearch:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<SearchCubit>(
                create: (context) => getIt<SearchCubit>(),
                child: GlobalSearchScreen(),
              ),
        );

      case RouteNames.viewSchedule:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ViewScheduleScreen(schedule: args['schedule']),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
