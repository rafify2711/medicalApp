import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/models/doctor_appointment_model.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import '../../../../core/di/di.dart';
import '../view_model/doctor_appointment_cubit.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorAppointmentsScreen> createState() => _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Upcoming', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<DoctorAppointmentCubit>().fetchDoctorAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Reservation> _filterAppointments(List<Reservation>? appointments, String tab) {
    if (appointments == null) return [];
    
    final now = DateTime.now();
    return appointments.where((appointment) {
      if (appointment.date == null) return false;
      
      final appointmentDate = appointment.date!;
      final isPast = appointmentDate.isBefore(now);
      final isCancelled = appointment.status?.toLowerCase() == 'cancelled';

      switch (tab) {
        case 'Upcoming':
          return !isPast && !isCancelled;
        case 'Completed':
          return isPast && !isCancelled;
        case 'Cancelled':
          return isCancelled;
        default:
          return false;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorAppointmentCubit, DoctorAppointmentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MyAppPar(title: 'My Appointments'),
          body: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primary,
                tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _tabs.map((tab) {
                    return _buildAppointmentsList(context, state, tab);
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppointmentsList(BuildContext context, DoctorAppointmentState state, String tab) {
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
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
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
      final filteredAppointments = _filterAppointments(state.appointments, tab);
      
      if (filteredAppointments.isEmpty) {
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
                'No $tab appointments',
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
        itemCount: filteredAppointments.length,
        itemBuilder: (context, index) {
          final appointment = filteredAppointments[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.patientDetails,
                  arguments: {
                    'patientData': {
                      'id': appointment.user?.id,
                      'name': appointment.user?.username,
                      'email': appointment.user?.email,
                      'phone': '+1 234 567 8900',
                      'age': '28',
                      'gender': 'Male',
                      'bloodType': 'O+',
                      'allergies': ['Penicillin', 'Pollen'],
                      'chronicDiseases': ['Hypertension'],
                      'medications': ['Lisinopril 10mg', 'Aspirin 81mg'],
                      'lastVisit': '2024-02-15',
                      'nextAppointment': appointment.date.toString(),
                      'medicalHistory': [
                        {
                          'date': '2024-01-15',
                          'diagnosis': 'Common Cold',
                          'treatment': 'Rest and fluids'
                        },
                        {
                          'date': '2023-12-01',
                          'diagnosis': 'Flu',
                          'treatment': 'Antiviral medication'
                        }
                      ]
                    }
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.user?.username ?? 'John Doe',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Age: 28 • Male • O+',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  appointment.date.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  appointment.timeSlot.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
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
                        appointment.status ?? '',
                        style: TextStyle(
                          color: _getStatusColor(appointment.status ?? ''),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
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