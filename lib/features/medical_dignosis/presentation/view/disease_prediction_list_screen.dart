import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/medical_dignosis/presentation/view/prediction_screen.dart';
import 'package:graduation_medical_app/features/medical_dignosis/presentation/view/prediction_history_screen.dart';
import '../../../../core/localization/app_localizations.dart';

class DiseasePredictionListScreen extends StatelessWidget {
  DiseasePredictionListScreen({super.key});

  List<Map<String, dynamic>> getDiseases(BuildContext context) => [
    {
      "name": "covid19",
      "displayName": AppLocalizations.of(context).covid19,
      "icon": Icons.coronavirus,
      "description": AppLocalizations.of(context).covid19Description,
    },
    {
      "name": "brain-tumor",
      "displayName": AppLocalizations.of(context).brainTumor,
      "icon": Icons.psychology,
      "description": AppLocalizations.of(context).brainTumorDescription,
    },
    {
      "name": "kidney-stone",
      "displayName": AppLocalizations.of(context).kidneyStone,
      "icon": Icons.medical_services,
      "description": AppLocalizations.of(context).kidneyStoneDescription,
    },
    {
      "name": "skin-cancer",
      "displayName": AppLocalizations.of(context).skinCancer,
      "icon": Icons.add,
      "description": AppLocalizations.of(context).skinCancerDescription,
    },
    {
      "name": "tuberculosis",
      "displayName": AppLocalizations.of(context).tuberculosis,
      "icon": Icons.air,
      "description": AppLocalizations.of(context).tuberculosisDescription,
    },
    {
      "name": "bone-fracture",
      "displayName": AppLocalizations.of(context).boneFracture,
      "icon": Icons.add,
      "description": AppLocalizations.of(context).boneFractureDescription,
    },
    {
      "name": "Alzheimer",
      "displayName": AppLocalizations.of(context).alzheimer,
      "icon": Icons.psychology_alt,
      "description": AppLocalizations.of(context).alzheimerDescription,
    },
    {
      "name": "eye-diseases",
      "displayName": AppLocalizations.of(context).eyeDiseases,
      "icon": Icons.visibility,
      "description": AppLocalizations.of(context).eyeDiseasesDescription,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final diseases = getDiseases(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).diseasePrediction),
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
              AppLocalizations.of(context).selectDisease,
              style: AppStyle.titlesTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).chooseDisease,
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
                                    disease["displayName"] as String,
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
