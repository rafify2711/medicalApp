


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_doctors_screen/user_doctors_screen.dart';

import '../../../../../core/utils/app_colors.dart';
import 'doc_model.dart';

class DoctorListScreen extends StatelessWidget {
  static const routeName='doctors_list_screen.dart';
  final List<DoctorModel> doctors = [
    DoctorModel(
      name: 'Dr. Daniel Rodriguez',
      specialty: 'Interventional Cardiologist',
      imageUrl: 'assets/images/doctor1.png',
    ),
    DoctorModel(
      name: 'Dr. Jessica Ramirez',
      specialty: 'Electrophysiologist',
      imageUrl: 'assets/images/doctor2.png',
    ),
    DoctorModel(
      name: 'Dr. Michael Chang',
      specialty: 'Cardiac Imaging Specialist',
      imageUrl: 'assets/images/doctor3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title:"doctors"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("Sort By"),
                const SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue.shade100,
                  ),
                  child: Text("A → Z"),
                ),
                Spacer(),
                TextButton(onPressed: () {}, child: Text("Filter",style: TextStyle(color: AppColors.primary),)),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doc = doctors[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(doc.imageUrl),
                        radius: 30,
                      ),
                      title: Text(doc.name,style: TextStyle(color: AppColors.primary)),
                      subtitle: Text(doc.specialty,style: TextStyle(color: AppColors.primary)),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoctorDetailsScreen(doctor: doc),
                            ),
                          );
                        },
                        child: Text("Info",style: TextStyle(color: AppColors.primary)),
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
