import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/medical_dignosis/presentation/view/prediction_screen.dart';

class DiseasePredictionListScreen extends StatelessWidget {
  DiseasePredictionListScreen({super.key});


  final List<String> diseases = [
    "covid19",
    "brain-tumor",
    "kidney-stone",
    "skin-cancer",
    "tuberculosis",
    "bone-fracture",
    "alzheimer",
    "eye-diseases"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: "Select a Disease"),
      body: ListView.separated(
        itemCount: diseases.length,
        separatorBuilder: (context, index) => Divider(
          thickness: 1, // سماكة الفاصل
          color: Colors.grey.shade300, // لون الفاصل
          indent: 16, // المسافة من اليسار
          endIndent: 16, // المسافة من اليمين
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              diseases[index],
              style: AppStyle.bodyCyanTextStyle.copyWith(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PredictionScreen(disease: diseases[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
