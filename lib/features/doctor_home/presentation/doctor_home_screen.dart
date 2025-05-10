import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';
class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

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
        String doctorName = AppLocalizations.of(context).doctor;
        String specialty = AppLocalizations.of(context).specialty;
        if (state is DoctorProfileLoaded) {
          doctorName = state.profile.username ?? AppLocalizations.of(context).doctor;
          specialty = state.profile.specialty ?? AppLocalizations.of(context).specialty;
        }
        
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).doctorHome),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.settings);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary1, AppColors.primary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 40, color: AppColors.primary1),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${AppLocalizations.of(context).welcomeDr} $doctorName',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                specialty,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quick Actions Section
                  Text(
                    AppLocalizations.of(context).quickActions,
                    style: AppStyle.bodyBlackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionCard(
                          context,
                          icon: Icons.add_circle_outline,
                          title: AppLocalizations.of(context).addAppointment,
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.doctorSchedule);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionCard(
                          context,
                          icon: Icons.people_outline,
                          title: AppLocalizations.of(context).viewPatients,
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.userAppointment);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Features Section
                  Text(
                    AppLocalizations.of(context).features,
                    style: AppStyle.bodyBlackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      _buildFeatureCard(
                        context,
                        icon: Icons.calendar_today,
                        title: AppLocalizations.of(context).appointments,
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.userAppointment);
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        icon: Icons.chat_bubble_outline,
                        title: AppLocalizations.of(context).chatBot,
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.chatbot);
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        icon: Icons.medical_services_outlined,
                        title: AppLocalizations.of(context).specialty,
                        onTap: () {
                          // Handle specialty
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        icon: Icons.settings_outlined,
                        title: AppLocalizations.of(context).settings,
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.settings);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: AppColors.primary1),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyle.bodyBlackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: AppColors.primary1),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyle.bodyBlackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}