import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/medical_dignosis/presentation/view/prediction_screen.dart';
import 'package:graduation_medical_app/features/medical_dignosis/presentation/view/prediction_history_screen.dart';

class DiseasePredictionListScreen extends StatelessWidget {
  DiseasePredictionListScreen({super.key});

  final List<Map<String, dynamic>> diseases = [
    {
      "name": "covid19",
      "icon": Icons.coronavirus,
      "description": "Predict COVID-19 from chest X-ray images",
    },
    {
      "name": "brain-tumor",
      "icon": Icons.psychology,
      "description": "Detect brain tumors from MRI scans",
    },
    {
      "name": "kidney-stone",
      "icon": Icons.medical_services,
      "description": "Identify kidney stones from ultrasound images",
    },
    {
      "name": "skin-cancer",
      "icon": Icons.add,
      "description": "Analyze skin lesions for cancer detection",
    },
    {
      "name": "tuberculosis",
      "icon": Icons.air,
      "description": "Detect tuberculosis from chest X-rays",
    },
    {
      "name": "bone-fracture",
      "icon": Icons.add,
      "description": "Identify bone fractures from X-ray images",
    },
    {
      "name": "Alzheimer",
      "icon": Icons.psychology_alt,
      "description": "Analyze brain scans for Alzheimer detection",
    },
    {
      "name": "eye-diseases",
      "icon": Icons.visibility,
      "description": "Detect various eye conditions from retinal images",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Disease Prediction"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PredictionHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select a Disease",
              style: AppStyle.titlesTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Choose a disease to analyze and get predictions",
              style: AppStyle.bodyBlackTextStyle.copyWith(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: diseases.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final disease = diseases[index];
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PredictionScreen(
                              disease: disease["name"].toString().toLowerCase(),
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primary1.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                disease["icon"] as IconData,
                                color: AppColors.primary1,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    disease["name"] as String,
                                    style: AppStyle.bodyBlackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    disease["description"] as String,
                                    style: AppStyle.bodyBlackTextStyle.copyWith(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[400],
                              size: 16,
                            ),
                          ],
                        ),
                      ),
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
