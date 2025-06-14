import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';

class MedicalRecordScreen extends StatelessWidget {
  final List<String>? medicalHistory;
  final List<String>? medicationHistory;

  const MedicalRecordScreen({
    Key? key,
    this.medicalHistory,
    this.medicationHistory,
  }) : super(key: key);

  Widget _buildListSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        ...items.map((item) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            elevation: 2,
            child: ListTile(
              title: Text(
                item,
                style: TextStyle(color: Colors.black87),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Medical Records',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppStyle.gradient,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Medical History Section
              _buildListSection(
                'Medical History',
                medicalHistory ?? [],
              ),
              
              SizedBox(height: 32),
              
              // Medication History Section
              _buildListSection(
                'Medication History',
                medicationHistory ?? [],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 