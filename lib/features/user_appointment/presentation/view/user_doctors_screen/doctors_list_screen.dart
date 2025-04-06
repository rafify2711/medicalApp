import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_doctors_screen/user_doctors_screen.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../auth/data/models/user_model/doctor_model.dart';
import '../../../../auth/data/models/user_model/doctors_model.dart';
import '../../../data/repository/all_doctor_repo_impl.dart';

class DoctorListScreen extends StatefulWidget {
  static const routeName = 'doctors_list_screen.dart';

  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final doctorRepository = getIt<DoctorRepository>();
  late Future<List<Doctor>> doctors;

  @override
  void initState() {
    super.initState();
    doctors = fetchDoctors(); // استدعاء دالة جلب البيانات عند بداية الواجهة
  }

  Future<List<Doctor>> fetchDoctors() async {
    try {
      return await doctorRepository.getAllDoctors(); // جلب الأطباء من الـ repository
    } catch (e) {
      print('Error fetching doctors: $e');
      return []; // في حالة حدوث خطأ نرجع قائمة فارغة
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: "Doctors"),
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
                TextButton(onPressed: () {}, child: Text("Filter", style: TextStyle(color: AppColors.primary))),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<Doctor>>(
                future: doctors,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No doctors found'));
                  }

                  final doctorsList = snapshot.data!; // استخدام قائمة الأطباء التي تم تحميلها

                  return ListView.builder(
                    itemCount: doctorsList.length,
                    itemBuilder: (context, index) {
                      final doctor = doctorsList[index]; // الحصول على بيانات الدكتور من القائمة
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:  AssetImage('assets/doctor_placeholder.png') as ImageProvider, // صورة افتراضية
                            radius: 30,
                          ),
                          title: Text(doctor.name, style: TextStyle(color: AppColors.primary)),
                          subtitle: Text(doctor.specialty!, style: TextStyle(color: AppColors.primary)),
                          trailing: ElevatedButton(
                            onPressed:(){}
                          ,
                            child: Text("Info", style: TextStyle(color: AppColors.primary)),
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
