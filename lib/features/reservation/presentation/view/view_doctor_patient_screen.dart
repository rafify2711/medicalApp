import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/models/doctor_appointment_model.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import '../../../../core/di/di.dart';
import '../view_model/doctor_appointment_cubit.dart';

class ViewDoctorPatientScreen extends StatefulWidget {
  const ViewDoctorPatientScreen({Key? key}) : super(key: key);

  @override
  State<ViewDoctorPatientScreen> createState() => _ViewDoctorPatientScreenState();
}

class _ViewDoctorPatientScreenState extends State<ViewDoctorPatientScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorAppointmentCubit>().fetchDoctorAppointments();
  }

  List<Reservation> _getTodayAppointments(List<Reservation>? appointments) {
    if (appointments == null) return [];
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    return appointments.where((appointment) {
      if (appointment.date == null) return false;
      
      final appointmentDate = appointment.date!;
      final appointmentDay = DateTime(
        appointmentDate.year,
        appointmentDate.month,
        appointmentDate.day,
      );
      
      return appointmentDay.isAtSameMomentAs(today);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorAppointmentCubit, DoctorAppointmentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MyAppPar(title: "Today's Appointments"),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, DoctorAppointmentState state) {
    if (state is DoctorAppointmentLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is DoctorAppointmentError) {
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
                context.read<DoctorAppointmentCubit>()
                  ..reset()
                  ..fetchDoctorAppointments();
              },
              child: Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    if (state is DoctorAppointmentSuccess) {
      final todayAppointments = _getTodayAppointments(state.appointments);
      
      if (todayAppointments.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                size: 64,
                color: AppColors.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No appointments for today',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: todayAppointments.length,
        itemBuilder: (context, index) {
          final appointment = todayAppointments[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.user?.username ?? 'Patient',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Appointment time: ${appointment.date ?? 'N/A'}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(appointment.status ?? '').withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          appointment.status ?? 'Pending',
                          style: TextStyle(
                            color: _getStatusColor(appointment.status ?? ''),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 8),
                      Text(
                        appointment.timeSlot ?? 'Time not specified',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          );
        },
      );
    }

    return const Center(child: Text('Unknown state'));
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return AppColors.primary;
    }
  }
}
