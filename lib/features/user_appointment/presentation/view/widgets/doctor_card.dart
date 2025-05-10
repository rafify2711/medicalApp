import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/models/appointment_model/appointment_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
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
      ),
    );
  }
}
