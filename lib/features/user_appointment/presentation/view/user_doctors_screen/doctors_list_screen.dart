import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_doctors_screen/user_doctors_screen.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/utils/app_colors.dart';

import '../../../../../core/utils/app_style.dart';
import '../../../../auth/presentation/view/widgets/button.dart';
import '../../../data/repository/all_doctor_repo_impl.dart';

class DoctorListScreen extends StatefulWidget {


  const DoctorListScreen({super.key});

  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final doctorRepository = getIt<DoctorRepository>();
  late Future<List<DoctorModel>> doctors;
  String selectedSpecialty = 'All'; // Variable to store selected specialty for filtering
  List<String> specialties = ['All', 'Cardiologist', 'Dentist', 'Pediatrician']; // List of specialties to filter by
  String searchQuery = ''; // Variable to store the search query

  @override
  void initState() {
    super.initState();
    doctors = fetchDoctors(); // Fetch the doctors on init
  }

  Future<List<DoctorModel>> fetchDoctors() async {
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase(); // Update search query on text change
                });
              },
              decoration: InputDecoration(
                hintText: "Search by name or specialty...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),fillColor: AppColors.primary

              ),
            ),
            const SizedBox(height: 16),

            // Sort and Filter Section
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

                // Dropdown for selecting specialty
                DropdownButton<String>(
                  value: selectedSpecialty,
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

                // Filter Button
                TextButton(
                  onPressed: () {
                    // You can implement more advanced filtering functionality here if needed
                  },
                  child: Text("Filter", style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // List of Doctors
            Expanded(
              child: FutureBuilder<List<DoctorModel>>(
                future: doctors,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No doctors found'));
                  }

                  // Filter the doctors based on selected specialty and search query
                  final doctorsList = snapshot.data!
                      .where((doctor) =>
                  (selectedSpecialty == 'All' || doctor.specialty == selectedSpecialty) &&
                      (doctor.username.toLowerCase().contains(searchQuery) ||
                          doctor.specialty.toLowerCase().contains(searchQuery)))
                      .toList();

                  return ListView.builder(
                    itemCount: doctorsList.length,
                    itemBuilder: (context, index) {
                      final doctor = doctorsList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/doctor_placeholder.png'),
                                radius: 30,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor.username,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Text(
                                      doctor.specialty!,
                                      style: TextStyle(color: AppColors.primary),
                                    ),
                                    SizedBox(height: 8),

                                  ],

                                ),
                              ),Spacer(),
                              SizedBox(
                                height: 50,
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DoctorDetailsScreen(doctor: doctor),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                                    elevation: MaterialStateProperty.all(0),
                                  ),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: AppStyle.gradient,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Info',
                                        style: AppStyle.bodyWhiteTextStyle.copyWith(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
