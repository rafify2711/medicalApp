import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/widgets/doctor_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/app_colors.dart';
import '../view_model/user_appointment_cubit.dart';
import '../view_model/user_appointment_state.dart';
import '../../../../core/localization/app_localizations.dart';

class UserAppointmentScreen extends StatefulWidget {
  @override
  _UserAppointmentScreenState createState() => _UserAppointmentScreenState();
}

class _UserAppointmentScreenState extends State<UserAppointmentScreen> {
  int selectedIndex = 1; // start with Upcoming
  String? userId;
  String? token;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndFetchAppointments();
  }

  Future<void> _loadUserIdAndFetchAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    token = prefs.getString("token");

    if (userId != null) {
      context.read<UserAppointmentCubit>().fetchAppointments(userId!, token!);
    }
  }

  List<dynamic> _filterAppointments(List<dynamic> appointments, int tabIndex) {
    if (appointments.isEmpty) return [];
    
    final now = DateTime.now();
    return appointments.where((appointment) {
      if (appointment.date == null) return false;
      
      final appointmentDate = appointment.date is String 
          ? DateTime.parse(appointment.date)
          : appointment.date as DateTime;
      final isPast = appointmentDate.isBefore(now);
      final isCancelled = appointment.status.toLowerCase() == 'cancelled';

      switch (tabIndex) {
        case 0: // Completed
          return isPast && !isCancelled;
        case 1: // Upcoming
          return !isPast && !isCancelled;
        case 2: // Cancelled
          return isCancelled;
        default:
          return false;
      }
    }).toList();
  }

  Widget buildTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary1.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTab(AppLocalizations.of(context).completed, 0),
          _buildTab(AppLocalizations.of(context).upcoming, 1),
          _buildTab(AppLocalizations.of(context).cancelled, 2),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary1 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.primary1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: AppLocalizations.of(context).appointments),
      body: Column(
        children: [
          SizedBox(height: 10),
          buildTabs(),
          Expanded(
            child: BlocBuilder<UserAppointmentCubit, UserAppointmentState>(
              builder: (context, state) {
                if (state is AppointmentLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AppointmentLoaded) {
                  final filteredAppointments = _filterAppointments(
                    state.appointments.reservations,
                    selectedIndex,
                  );

                  if (filteredAppointments.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 64,
                            color: AppColors.primary1.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context).noAppointments,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primary1,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = filteredAppointments[index];
                      return AppointmentCard(appointment: appointment);
                    },
                  );
                } else if (state is AppointmentError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (userId != null && token != null) {
                              context.read<UserAppointmentCubit>()
                                ..fetchAppointments(userId!, token!);
                            }
                          },
                          child: Text(AppLocalizations.of(context).retry),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary1,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text(AppLocalizations.of(context).noData));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
