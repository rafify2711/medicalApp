import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/di/di.dart';
import 'package:graduation_medical_app/core/extentions/extentions.dart';
import 'package:graduation_medical_app/core/models/user_model/user_model.dart';
import 'package:graduation_medical_app/core/utils/widgets/feature_widget/devider.dart';
import 'package:graduation_medical_app/features/user_home/presentation/view/widgets/cat_icons_row.dart';
import 'package:graduation_medical_app/features/user_home/presentation/view/widgets/home_app_bar.dart';
import 'package:graduation_medical_app/features/user_profile/presentation/view_model/user_profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/models/appointment_model/appointment_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/widgets/feature_widget/features.dart';
import '../../../user_appointment/presentation/view_model/user_appointment_cubit.dart';
import '../../../user_appointment/presentation/view_model/user_appointment_state.dart';
import '../../../search/presentation/view_model/search_cubit.dart';
import '../../../../core/localization/app_localizations.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  DateTime selectedCalenderDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    final token = prefs.getString("token");

    if (userId != null && token != null) {
      context.read<UserAppointmentCubit>().fetchAppointments(userId, token);
      context.read<UserProfileCubit>().fetchUserProfile(token, userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            kToolbarHeight,
          ),
          child: BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              UserModel? user = UserModel(
                id: '0',
                username: AppLocalizations.of(context).username,
                email: 'email',
              );

              if (state is UserProfileLoaded) {
                user = state.profile.user;
              }

              return HomeAppBar(user: user);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).categories,
                  style: TextStyle(
                    color: AppColors.primary1,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Center(child: AppDivider()),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: CatIconsRow(),
            ),
            const SizedBox(height: 10),
            buildCalender(),
            const SizedBox(height: 10),
            AppDivider(),
            const SizedBox(height: 16),
            Expanded(
              child: GridView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                ),
                children: [
                  FeatureCard(
                    icon: Icons.medical_services,
                    label: AppLocalizations.of(context).diagnosis,
                    routeName: RouteNames.diseasePredictionList,
                  ),
                  FeatureCard(
                    icon: Icons.people,
                    label: AppLocalizations.of(context).doctors,
                    routeName: RouteNames.doctorList,
                  ),
                  FeatureCard(
                    image: 'lib/assets/icon/medicine.png',
                    label: AppLocalizations.of(context).drugs,
                    routeName: RouteNames.drugTabs,
                  ),
                  FeatureCard(
                    icon: Icons.calendar_today,
                    label: AppLocalizations.of(context).schedule,
                    routeName: RouteNames.userAppointment,
                  ),
                  FeatureCard(
                    icon: Icons.chat,
                    label: AppLocalizations.of(context).chatBot,
                    routeName: RouteNames.chatbot,
                  ),
                  FeatureCard(
                    icon: Icons.chrome_reader_mode_outlined,
                    label: AppLocalizations.of(context).prescriptions,
                    routeName: RouteNames.readPrescription,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCalender() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppStyle.gradient,
      ),
      width: double.infinity,
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
            headerBuilder: (context, date) => Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      AppLocalizations.of(context).upcomingSchedule,
                      style: AppStyle.bodyWhiteTextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Text(
                      months[selectedCalenderDate.month].toString(),
                      style: AppStyle.bodyWhiteTextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: AppDivider(),
                ),
              ],
            ),
            firstDate: DateTime.now().subtract(Duration(days: 30)),
            focusDate: selectedCalenderDate,
            lastDate: DateTime.now().add(Duration(days: 30)),
            dayProps: EasyDayProps(
              height: 90,
              width: 65,
            ),
            onDateChange: (selectedDate) {
              setState(() => selectedCalenderDate = selectedDate);
            },
            itemBuilder: (context, date, isSelected, onTap) => GestureDetector(
              onTap: () => setState(() => selectedCalenderDate = date),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.white),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: isSelected ? AppColors.primary1 : AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      date.dayName,
                      style: TextStyle(
                        color: isSelected ? AppColors.primary1 : AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 160,
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.white),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    AppLocalizations.of(context).appointments,
                    style: AppStyle.titlesTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<UserAppointmentCubit, UserAppointmentState>(
                    builder: (context, state) {
                      if (state is AppointmentLoaded) {
                        final filtered = state.appointments.reservations.where((a) {
                          final date = a.date;
                          return date.year == selectedCalenderDate.year &&
                              date.month == selectedCalenderDate.month &&
                              date.day == selectedCalenderDate.day &&
                              a.status.toLowerCase() == "confirmed";
                        }).toList();

                        if (filtered.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              AppLocalizations.of(context).noAppointmentsToday,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final appointment = filtered[index];
                            return _buildAppointmentItem(appointment);
                          },
                        );
                      } else if (state is AppointmentLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      
                      return Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          AppLocalizations.of(context).noData,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(AppointmentModel appointment) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.doctor.name ?? AppLocalizations.of(context).doctor,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, color: AppColors.white, size: 15),
                const SizedBox(width: 4),
                Text(
                  appointment.timeSlot ?? '00:00',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            AppDivider()
          ],
        ),
      ),
    );
  }
}
