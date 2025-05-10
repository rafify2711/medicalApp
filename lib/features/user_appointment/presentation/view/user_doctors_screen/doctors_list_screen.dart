import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_doctors_screen/user_doctors_screen.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../data/models/doctor_model/doctor_model.dart';
import '../../../data/repository/all_doctor_repo_impl.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final doctorRepository = getIt<DoctorRepository>();
  late Future<List<DoctorsModel>> doctors;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    doctors = fetchDoctors();
  }

  Future<List<DoctorsModel>> fetchDoctors() async {
    try {
      return await doctorRepository.getAllDoctors();
    } catch (e) {
      print('Error fetching doctors: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: AppLocalizations.of(context).doctors),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).findYourDoctor,
                    style: AppStyle.titlesTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context).browseAndBookAppointments,
                    style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).searchDoctors,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DoctorsModel>>(
                future: doctors,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).errorOccurred,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).noDoctorsFound,
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  var filteredDoctors = snapshot.data!.where((doctor) {
                    return doctor.username!.toLowerCase().contains(searchQuery.toLowerCase()) ||
                        doctor.specialty!.toLowerCase().contains(searchQuery.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = filteredDoctors[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(doctor.profilePhoto ?? ''),
                          ),
                          title: Text(
                            doctor.username ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Text(
                                doctor.specialty ?? '',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '0.0',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/doctorDetails',
                                arguments: doctor,
                              );
                            },
                            child: Text(AppLocalizations.of(context).viewProfile),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF30948F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
