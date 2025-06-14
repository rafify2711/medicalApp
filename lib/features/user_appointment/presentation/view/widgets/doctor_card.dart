import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/models/appointment_model/appointment_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../view_model/user_appointment_cubit.dart';
import '../../view_model/user_appointment_state.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentCard({required this.appointment});

  Future<bool?> _showCancelConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).cancelAppointment),
          content: Text('Are you sure you want to cancel this appointment?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                AppLocalizations.of(context).no,
                style: TextStyle(color: AppColors.primary1),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                AppLocalizations.of(context).yes,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary1,
                  child: Text(
                    appointment.doctor.name[0].toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  radius: 30,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctor.name,
                        style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.black),
                      ),
                      Text(appointment.doctor.specialization),
                      SizedBox(height: 8),
                      Text(
                        "${AppLocalizations.of(context).date}: ${appointment.date.toLocal().toString().split(' ')[0]}",
                        style: TextStyle(fontSize: 12, color: Colors.grey)
                      ),
                      Row(
                        children: [
                          Text(
                            "${AppLocalizations.of(context).status}: ",
                            style: TextStyle(fontSize: 12, color: Colors.grey)
                          ),
                          SizedBox(width: 4),
                          Text(
                            appointment.status,
                            style: TextStyle(fontSize: 12, color: AppColors.primary1)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (appointment.status.toLowerCase() != 'cancelled')
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: BlocBuilder<UserAppointmentCubit, UserAppointmentState>(
                  builder: (context, state) {
                    final isLoading = state is CancelReservationLoading;
                    final now = DateTime.now();
                    final appointmentDate = appointment.date is String 
                        ? DateTime.parse(appointment.date.toString())
                        : appointment.date as DateTime;
                    final isUpcoming = !appointmentDate.isBefore(now);

                    if (!isUpcoming) return SizedBox.shrink();

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () async {
                          final shouldCancel = await _showCancelConfirmationDialog(context);
                          if (shouldCancel == true) {
                            context.read<UserAppointmentCubit>().cancelReservation(appointment.id);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(AppLocalizations.of(context).cancel),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
