import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/extentions/extentions.dart';
import 'package:graduation_medical_app/core/models/user_model/user_model.dart';
import 'package:graduation_medical_app/features/user_home/presentation/view/widgets/home_app_bar.dart';
import 'package:graduation_medical_app/features/user_profile/presentation/view_model/user_profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/models/appointment_model/appointment_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/widgets/feature_widget/features.dart';
import '../../../auth/presentation/view/widgets/my_app_par.dart';
import '../../../user_appointment/presentation/view_model/user_appointment_cubit.dart';
import '../../../user_appointment/presentation/view_model/user_appointment_state.dart';

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
    return Scaffold(
     appBar: PreferredSize(
       preferredSize: Size.fromHeight(kToolbarHeight), // Set preferred size for the app bar
       child: BlocBuilder<UserProfileCubit, UserProfileState>(
         builder: (context, state) {
           UserModel? user = UserModel(id: '0', username: "username", email: 'email'); // Default fallback name

           if (state is UserProfileLoaded) {
             user = state.profile.user; // Adjust based on the actual data structure
           }

           return HomeAppBar(user: user); // Pass the user data to the AppBar
         },
       ),
     ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            buildCalender(),
            const SizedBox(height: 24),
        Container(
          height: 1,
          width: MediaQuery
              .of(context)
              .size
              .width * 7,

          color: AppColors.primary,),
            const SizedBox(height: 16),
            Expanded(
              child: GridView(
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
                      label: 'Diagnosis',
                      routeName: RouteNames.diseasePredictionList),
                  FeatureCard(
                      icon: Icons.people,
                      label: 'Doctors',
                      routeName: RouteNames.doctorList),
                  FeatureCard(
                      image: 'lib/assets/icon/medicine.png',
                      label: 'Drugs',
                      routeName: RouteNames.drugTabs),
                  FeatureCard(
                      icon: Icons.calendar_today,
                      label: 'Schedule',
                      routeName: RouteNames.userAppointment),
                  FeatureCard(
                      icon: Icons.chat,
                      label: 'Chat Bot',
                      routeName: RouteNames.chatbot),
                  FeatureCard(
                      icon: Icons.chrome_reader_mode_outlined,
                      label: 'Perception',
                      routeName: RouteNames.readPrescription),
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
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          gradient: AppStyle.gradient, borderRadius: BorderRadius.circular(12)),
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
            headerBuilder:
                (context, date) =>
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          'upcoming schedule',
                          style: AppStyle.bodyWhiteTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Text(
                          months[selectedCalenderDate.month].toString(),
                          style: AppStyle.bodyWhiteTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 7,

                      color: AppColors.white,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
            firstDate: DateTime.now().subtract(Duration(days: 30)),
            focusDate: selectedCalenderDate,
            lastDate: DateTime.now().add(Duration(days: 30)),
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
                    SizedBox(
                      height: 40,
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        date.dayName,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
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
                    'Appointments',
                    style: AppStyle.titlesTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 16,
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
                            child: Text("No appointments today",
                                style: TextStyle(color: Colors.white)),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final appointment = filtered[index];
                              return _buildAppointmentItem(appointment);
                            },
                          ),
                        );
                      } else if (state is AppointmentLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text("No data", style: TextStyle(color: Colors.white)),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(AppointmentModel appointment) {
    return Padding(padding: EdgeInsets.all(8),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.doctor.name ?? 'Doctor',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, color: AppColors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  appointment.timeSlot ?? '00:00',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ],

            ),
            const SizedBox(height: 4),
            Divider(height: 1, color: Colors.white),
          ],
        ),
      ),
    );
  }
}


