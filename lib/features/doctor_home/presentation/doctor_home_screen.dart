import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/extentions/extentions.dart';
import 'package:graduation_medical_app/core/utils/widgets/feature_widget/features.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view/add_doctor_scadule.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';
import '../../chat_bot/presentation/view/chatbot_screen.dart';
import '../../medical_dignosis/presentation/view/disease_prediction_list_screen.dart';
import '../../user_appointment/presentation/view/user_appointment_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  List months = [
    '0',
    'jan',
    'feb',
    'mar',
    'april',
    'may',
    'jun',
    'july',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec',
  ];
  DateTime selectedCalenderDate = DateTime.now();
  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  void _loadAppointments() {
    // Simulated appointments data - replace with actual data from your backend
    appointments = [
      {
        'patientName': 'Ahmed Mohamed',
        'time': '10:00 AM - 11:00 AM',
        'date': DateTime.now(),
      },
      {
        'patientName': 'Sara Ali',
        'time': '11:30 AM - 12:30 PM',
        'date': DateTime.now(),
      },
      {
        'patientName': 'Mohamed Hassan',
        'time': '2:00 PM - 3:00 PM',
        'date': DateTime.now().add(Duration(days: 1)),
      },
      {
        'patientName': 'Fatima Ahmed',
        'time': '3:30 PM - 4:30 PM',
        'date': DateTime.now().add(Duration(days: 1)),
      },
      {
        'patientName': 'Omar Ibrahim',
        'time': '5:00 PM - 6:00 PM',
        'date': DateTime.now().add(Duration(days: 2)),
      },
    ];
  }

  List<Map<String, dynamic>> getAppointmentsForDate(DateTime date) {
    return appointments.where((appointment) {
      final appointmentDate = appointment['date'] as DateTime;
      return appointmentDate.year == date.year &&
          appointmentDate.month == date.month &&
          appointmentDate.day == date.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        String doctorName = "Doctor";
        String specialty = "Specialist";
        if (state is DoctorProfileLoaded) {
          doctorName = state.profile.username ?? "Doctor";
          specialty = state.profile.specialty ?? "Specialist";
        }
        
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppStyle.gradient,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Text(
                          doctorName[0].toUpperCase(),
                          style: TextStyle(
                            color: AppColors.primary1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              specialty,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications_outlined, color: Colors.white),
                        onPressed: () {
                          // Handle notifications
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.settings_outlined, color: Colors.white),
                        onPressed: () {
                          // Handle settings
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildStatisticsSection(),
                  const SizedBox(height: 24),
                  buildCalender(),
                  const SizedBox(height: 24),
                  const Text(
                    'Quick Actions',
                    style: AppStyle.titlesTextStyle,
                  ),
                  const SizedBox(height: 16),
                  _buildQuickActions(),
                  const SizedBox(height: 24),
                  const Text(
                    'Features',
                    style: AppStyle.titlesTextStyle,
                  ),
                  const SizedBox(height: 16),
                  _buildFeaturesGrid(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatisticsSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.people, "Today's\nAppointments", "5"),
          _buildStatItem(Icons.check_circle, "Completed\nAppointments", "12"),
          _buildStatItem(Icons.pending, "Pending\nAppointments", "3"),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary1.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary1, size: 24),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary1,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildQuickActionItem(Icons.add_circle, "New\nAppointment", () {
            Navigator.pushNamed(context, RouteNames.doctorSchedule);
          }),
          _buildQuickActionItem(Icons.medical_services, "View\nPatients", () {
            Navigator.pushNamed(context, RouteNames.userAppointment);
          }),
          _buildQuickActionItem(Icons.chat, "Chat\nBot", () {
            Navigator.pushNamed(context, RouteNames.chatbot);
          }),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary1.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary1, size: 24),
          ),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        FeatureCard(
          icon: Icons.medical_services,
          label: 'Diagnosis',
          routeName: RouteNames.diseasePredictionList,
        ),
        FeatureCard(
          icon: Icons.people,
          label: 'Patients',
          routeName: RouteNames.userAppointment,
        ),
        FeatureCard(
          icon: Icons.insert_chart,
          label: 'Reports',
          routeName: '',
        ),
        FeatureCard(
          icon: Icons.calendar_today,
          label: 'Schedule',
          routeName: RouteNames.doctorSchedule,
        ),
        FeatureCard(
          icon: Icons.chat,
          label: 'Chat Bot',
          routeName: RouteNames.chatbot,
        ),
        FeatureCard(
          icon: Icons.chrome_reader_mode_outlined,
          label: 'Prescriptions',
          routeName: '',
        ),
      ],
    );
  }

  Widget buildCalender() {
    final appointmentsForSelectedDate = getAppointmentsForDate(selectedCalenderDate);
    
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
                      'upcoming schedule',
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
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 7,
                    color: AppColors.white,
                  ),
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
                    'Appointments',
                    style: AppStyle.titlesTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: appointmentsForSelectedDate.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            "You have no appointments today",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(left: 12, bottom: 12),
                          itemCount: appointmentsForSelectedDate.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final appointment = appointmentsForSelectedDate[index];
                            return _buildAppointmentItem(appointment);
                          },
                        ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(Map<String, dynamic> appointment) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment['patientName'],
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
                  appointment['time'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 7,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}