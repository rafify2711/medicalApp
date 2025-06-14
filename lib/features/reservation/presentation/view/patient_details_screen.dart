import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> patientData;

  const PatientDetailsScreen({Key? key, required this.patientData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final cardColor = isDarkMode ? const Color(0xFF2D2D2D) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final secondaryTextColor = isDarkMode ? Colors.grey[300] : Colors.grey[700];
    final dividerColor = isDarkMode ? Colors.grey[800] : Colors.grey[200];
    final chipColor = isDarkMode ? AppColors.primary.withOpacity(0.2) : AppColors.primary.withOpacity(0.1);
    final historyItemColor = isDarkMode ? const Color(0xFF3D3D3D) : Colors.grey[50];
    final titleColor = AppColors.primary;

    return Scaffold(
      appBar: MyAppPar(title: 'Patient Details'),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Basic Information',
              children: [
                _buildInfoRow('Name', patientData['name'] ?? 'N/A', textColor, secondaryTextColor ?? Colors.grey),
                _buildInfoRow('Age', patientData['age'] ?? 'N/A', textColor, secondaryTextColor ?? Colors.grey),
                _buildInfoRow('Gender', patientData['gender'] ?? 'N/A', textColor, secondaryTextColor ?? Colors.grey),
                _buildInfoRow('Blood Type', patientData['bloodType'] ?? 'N/A', textColor, secondaryTextColor ?? Colors.grey),
              ],
              cardColor: cardColor,
              titleColor: titleColor,
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Contact Information',
              children: [
                _buildInfoRow('Email', patientData['email'] ?? 'N/A', textColor, secondaryTextColor ?? Colors.grey),
                _buildInfoRow('Phone', patientData['phone'] ?? 'N/A', textColor, secondaryTextColor ?? Colors.grey),
              ],
              cardColor: cardColor,
              titleColor: titleColor,
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Medical Information',
              children: [
                _buildListInfo('Allergies', patientData['allergies'] ?? [], textColor, secondaryTextColor ?? Colors.grey, chipColor),
                _buildListInfo('Chronic Diseases', patientData['chronicDiseases'] ?? [], textColor, secondaryTextColor ?? Colors.grey, chipColor),
                _buildListInfo('Current Medications', patientData['medications'] ?? [], textColor, secondaryTextColor ?? Colors.grey, chipColor),
              ],
              cardColor: cardColor,
              titleColor: titleColor,
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Visit History',
              children: [
                _buildInfoRow('Last Visit', patientData['lastVisit'] ?? 'N/A', textColor, secondaryTextColor ?? Colors.grey),
                _buildInfoRow('Next Appointment', patientData['nextAppointment'] ?? 'N/A', textColor, secondaryTextColor ?? Colors.grey),
              ],
              cardColor: cardColor,
              titleColor: titleColor,
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Medical History',
              children: [
                if (patientData['medicalHistory'] != null)
                  ...(patientData['medicalHistory'] as List).map((history) => 
                    _buildHistoryItem(
                      history, 
                      textColor, 
                      secondaryTextColor ?? Colors.grey, 
                      historyItemColor!,
                      dividerColor ?? Colors.grey
                    )
                  ),
              ],
              cardColor: cardColor,
              titleColor: titleColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
    required Color cardColor,
    required Color titleColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, Color textColor, Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: secondaryTextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListInfo(String label, List<dynamic> items, Color textColor, Color secondaryTextColor, Color chipColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          if (items.isEmpty)
            Text('None', style: TextStyle(fontSize: 16, color: textColor))
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items.map((item) => Chip(
                label: Text(
                  item.toString(),
                  style: TextStyle(color: AppColors.primary),
                ),
                backgroundColor: chipColor,
              )).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> history, Color textColor, Color secondaryTextColor, Color itemColor, Color borderColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: itemColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            history['date'] ?? 'N/A',
            style: TextStyle(
              fontSize: 14,
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Diagnosis: ${history['diagnosis'] ?? 'N/A'}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Treatment: ${history['treatment'] ?? 'N/A'}',
            style: TextStyle(
              fontSize: 14,
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
} 