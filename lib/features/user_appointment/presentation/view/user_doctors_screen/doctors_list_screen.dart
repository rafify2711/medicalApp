import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_doctors_screen/user_doctors_screen.dart';

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
  String selectedSpecialty = 'All'; // Variable to store selected specialty for filtering
  List<String> specialties = ['All', 'Cardiologist', 'Dentist', 'Pediatrician']; // List of specialties to filter by
  String searchQuery = ''; // Variable to store the search query

  @override
  void initState() {
    super.initState();
    doctors = fetchDoctors(); // Fetch the doctors on init
  }

  Future<List<DoctorsModel>> fetchDoctors() async {
    try {
      return await doctorRepository.getAllDoctors(); // Fetch doctors from the repository
    } catch (e) {
      print('Error fetching doctors: $e');
      return []; // Return empty list in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: "Doctors"),
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
                    "Find Your Doctor",
                    style: AppStyle.titlesTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Browse and book appointments with top doctors",
                    style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  // Search Bar
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search by name or specialty...",
                        prefixIcon: Icon(Icons.search, color: AppColors.primary1),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Sort and Filter Section
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.sort, size: 18, color: AppColors.primary1),
                            SizedBox(width: 4),
                            Text("A → Z", style: TextStyle(color: AppColors.primary1)),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedSpecialty,
                            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.primary1),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSpecialty = newValue!;
                              });
                            },
                            items: specialties.map<DropdownMenuItem<String>>((String specialty) {
                              return DropdownMenuItem<String>(
                                value: specialty,
                                child: Text(specialty),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary1.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.filter_alt, color: AppColors.primary1),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // List of Doctors
            Expanded(
              child: FutureBuilder<List<DoctorsModel>>(
                future: doctors,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: \\${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.medical_services, size: 64, color: Colors.grey[300]),
                          SizedBox(height: 16),
                          Text('No doctors found', style: TextStyle(color: Colors.grey[600], fontSize: 18)),
                        ],
                      ),
                    );
                  }
                  final doctorsList = snapshot.data!
                      .where((doctor) =>
                          (selectedSpecialty == 'All' || doctor.specialty == selectedSpecialty) &&
                          (doctor.username!.toLowerCase().contains(searchQuery) ||
                              doctor.specialty!.toLowerCase().contains(searchQuery)))
                      .toList();
                  return ListView.builder(
                    itemCount: doctorsList.length,
                    padding: EdgeInsets.only(bottom: 16, top: 8),
                    itemBuilder: (context, index) {
                      final doctor = doctorsList[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/doctor_placeholder.png'),
                            radius: 30,
                          ),
                          title: Text(
                            doctor.username!,
                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary1, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Text(
                                doctor.specialty!,
                                style: TextStyle(color: Colors.grey[700], fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              // Optionally add more info here (e.g., rating, experience)
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDetailsScreen(doctor: doctor),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                              backgroundColor: AppColors.primary1,
                            ),
                            child: Text('Info', style: AppStyle.bodyWhiteTextStyle.copyWith(fontSize: 14)),
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
