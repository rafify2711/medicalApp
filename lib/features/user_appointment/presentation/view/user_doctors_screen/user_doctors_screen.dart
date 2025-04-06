import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/doctor_model/doctor_model.dart';
import '../../../../auth/presentation/view/widgets/my_app_par.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: '${doctor.username}'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(doctor.profilePhoto??""),
                radius: 60,
              ),
              const SizedBox(height: 20),
              Text(
                doctor.username,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(doctor.specialty, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              Text(
                "Doctor bio or additional info goes here...",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
