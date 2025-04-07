import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:graduation_medical_app/core/extentions/extentions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/models/appointment_model/appointment_model.dart';
import '../../../../core/models/doctor_model/doctor_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/widgets/feature_widget/features.dart';
import '../../../auth/presentation/view/widgets/my_app_par.dart';
import '../../../chat_bot/presentation/view/chatbot_screen.dart';
import '../../../drug_conflict/presentation/view/drug_tabs.dart';
import '../../../medical_dignosis/presentation/view/disease_prediction_list_screen.dart';
import '../../../user_appointment/presentation/view/user_appointment_screen.dart';
import '../../../user_appointment/presentation/view/user_doctors_screen/doctors_list_screen.dart';
import '../../../user_appointment/presentation/view_model/user_appointment_cubit.dart';
import '../../../user_appointment/presentation/view_model/user_appointment_state.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});
  static const String routeName = 'user_home_screen';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: "User"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              buildCalender(),
              const SizedBox(height: 24),
              const Text('Features', style: AppStyle.titlesTextStyle),
              const SizedBox(height: 16),
              GridView(
                physics: const NeverScrollableScrollPhysics(),
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
                      routeName: DiseasePredictionListScreen.routeName),
                  FeatureCard(
                      icon: Icons.people,
                      label: 'Doctors',
                      routeName: DoctorListScreen.routeName),
                  FeatureCard(
                      image: 'lib/assets/icon/medicine.png',
                      label: 'Drugs',
                      routeName: DrugTabsScreen.routeName),
                  FeatureCard(
                      icon: Icons.calendar_today,
                      label: 'Schedule',
                      routeName: UserAppointmentScreen.routeName),
                  FeatureCard(
                      icon: Icons.chat,
                      label: 'Chat Bot',
                      routeName: ChatbotScreen.routeName),
                  FeatureCard(
                      icon: Icons.chrome_reader_mode_outlined,
                      label: 'Perception',
                      routeName: ''),
                ],
              ),
            ],
          ),
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

                        return ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final appointment = filtered[index];
                            return _buildAppointmentItem(appointment);
                          },
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
