import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/features/edit_profile/presentation/view_model/update_user_Profile_cubit.dart';
import 'package:graduation_medical_app/features/hospitals_and_pharmacies/presentation/view/hospitals_screen.dart';
import 'package:graduation_medical_app/features/hospitals_and_pharmacies/presentation/view/pharmacies_screen.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view/view_doctor_patient_screen.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view_model/add_update_schedule_cubit.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view_model/doctor_appointment_cubit.dart';
import 'package:graduation_medical_app/features/search/presentation/view_model/search_cubit.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view_model/available_slots_cubit.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view_model/make_reservation_cubit.dart';
import '../../features/auth/presentation/view/screens/log_in_screen.dart';
import '../../features/auth/presentation/view/screens/sign_up_screen.dart';
import '../../features/auth/presentation/view_model/auth_cubit.dart';
import '../../features/auth/presentation/view_model/forget_reset_password_cubit.dart';
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
import '../../features/onboarding/presentation/view/onboarding_screen.dart';
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
import '../../features/user_profile/presentation/view_model/upload_photo_cubit.dart';
import '../../features/user_profile/presentation/view_model/user_profile_cubit.dart';
import '../di/di.dart';
import '../models/doctor_model/doctor_model.dart';
import '../../features/reservation/presentation/view/view_schedule_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/reservation/presentation/view/doctor_appointments_screen.dart';
import '../../features/auth/presentation/view/screens/change_password_screen.dart';
import '../../features/user_appointment/presentation/view/specialties_screen.dart';
import '../../features/auth/presentation/view/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/view/screens/reset_password_screen.dart';
import '../../features/reservation/presentation/view/patient_details_screen.dart';

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

      case RouteNames.onboarding:
        return MaterialPageRoute(
          builder:
              (_) => OnboardingScreen(),
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
                child: DoctorHomeScreen(userId: '',),
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
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<UserAppointmentCubit>(
                    create: (context) => getIt<UserAppointmentCubit>(),
                  ),
                  BlocProvider<ScheduleCubit>(
                    create: (context) => getIt<ScheduleCubit>(),
                  ),
                ],
                child: UserAppointmentScreen(),
              ),
        );


      case RouteNames.viewdoctorpatient:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<UserAppointmentCubit>(
            create: (context) => getIt<UserAppointmentCubit>(),
            child: ViewDoctorPatientScreen(),
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
        final args = settings.arguments as Map<String, dynamic>;
        final doctor = args['doctor'] as DoctorsModel;
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
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<UpdateUserProfileCubit>(
                    create: (context) => getIt<UpdateUserProfileCubit>(),
                  ),
                  BlocProvider<UploadProfilePhotoCubit>(
                    create: (context) => getIt<UploadProfilePhotoCubit>(),
                  ),
                ],
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
              selectedDate: args['selectedDate']
            ),
          ),
        );

      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case RouteNames.welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());

      case RouteNames.hospital:
        return MaterialPageRoute(
          builder: (_) => HospitalScreen(
          ),
        );

      case RouteNames.pharmacy:
        return MaterialPageRoute(
          builder: (_) => PharmacyListScreen(
          ),
        );

      case RouteNames.globalSearch:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<SearchCubit>(
                create: (context) => getIt<SearchCubit>(),
                child: GlobalSearchScreen(),
              ),
        );

      case RouteNames.viewSchedule:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ScheduleCubit>(create:  (context) => getIt<ScheduleCubit>(),
              child: ViewScheduleScreen(doctorId: '', token: '',)),
        );

      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case RouteNames.doctorAppointments:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<DoctorAppointmentCubit>(create:  (context) => getIt<DoctorAppointmentCubit>() ,child: DoctorAppointmentsScreen()),
        );

      case RouteNames.changePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<DoctorAppointmentCubit>(create:  (context) => getIt<DoctorAppointmentCubit>() ,child: ChangePasswordScreen()),
        );

      case RouteNames.specialties:
        return MaterialPageRoute(
          builder: (_) => const SpecialtiesScreen(),
        );

      case RouteNames.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ForgotResetPasswordCubit>(
            create: (context) => getIt<ForgotResetPasswordCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        );

      case RouteNames.resetPassword:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ForgotResetPasswordCubit>(
            create: (context) => getIt<ForgotResetPasswordCubit>(),
            child: ResetPasswordScreen(email: email),
          ),
        );

      case RouteNames.patientDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PatientDetailsScreen(
            patientData: args['patientData'],
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
