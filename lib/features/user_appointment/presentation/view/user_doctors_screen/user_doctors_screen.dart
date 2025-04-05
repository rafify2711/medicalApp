import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../auth/presentation/view/widgets/my_app_par.dart';
import 'doc_model.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: '${doctor.name}'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(doctor.imageUrl),
                radius: 60,
              ),
              const SizedBox(height: 20),
              Text(
                doctor.name,
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
