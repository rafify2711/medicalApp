import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';

import '../../../../core/utils/app_colors.dart';

class UserAppointmentScreen extends StatefulWidget {

  static const routeName ='user_appointment_screen.dart';
  @override


  _UserAppointmentScreenState createState() => _UserAppointmentScreenState();
}

class _UserAppointmentScreenState extends State<UserAppointmentScreen> {
  int selectedIndex = 0; // 0: Complete, 1: Upcoming, 2: Cancelled

  @override
  Widget build(BuildContext context) {
    List<Widget> appointmentLists = [
      buildAppointmentList(completedAppointments),
      buildAppointmentList(upcomingAppointments),
      buildAppointmentList(cancelledAppointments),
    ];

    return Scaffold(
      appBar: MyAppPar(title: 'Appointment'),
      body: Column(
        children: [
          SizedBox(height: 10),
          buildTabs(),
          Expanded(child: appointmentLists[selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
        ],
      ),
    );
  }

  Widget buildTabs() {
    List<String> tabs = ["Complete", "Upcoming", "Cancelled"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (index) {
        return ChoiceChip(

          shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20)) ),
          label: Text(tabs[index]),
          selected: selectedIndex == index,
          selectedColor: AppColors.primary,
          onSelected: (bool selected) {
            setState(() {
              selectedIndex = index;
            });
          },
        );
      }),
    );
  }

  Widget buildAppointmentList(List<DoctorInfo> doctors) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return DoctorCard(doctor: doctor);
      },
    );
  }
}

// Doctor Model
class DoctorInfo {
  final String name;
  final String specialty;
  final int rating;
  final String imageUrl;
  final String date; // New field for date
  final String hour; // New field for hour

  DoctorInfo(this.name, this.specialty, this.rating, this.imageUrl, this.date, this.hour);
}


// Dummy Data with date and hour added
final List<DoctorInfo> completedAppointments = [
  DoctorInfo("Dr. Emma Hall, M.D.", "General Doctor", 5, "assets/doctor1.png", "2025-04-05", "10:00 AM"),
  DoctorInfo("Dr. Quinn Cooper, M.D.", "Geriatric Gynecology", 5, "assets/doctor3.png", "2025-04-06", "12:00 PM"),
];

final List<DoctorInfo> upcomingAppointments = [
  DoctorInfo("Dr. Jacob Lopez, M.D.", "Surgical Dermatology", 4, "assets/doctor2.png", "2025-04-07", "02:00 PM"),
];

final List<DoctorInfo> cancelledAppointments = [
  DoctorInfo("Dr. Lucy Perez, Ph.D.", "Clinical Dermatology", 5, "assets/doctor4.png", "2025-04-08", "04:00 PM"),
];

// Doctor Card
class DoctorCard extends StatelessWidget {
  final DoctorInfo doctor;

  const DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(doctor.imageUrl),
              radius: 30,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                  Text(doctor.specialty),
                  SizedBox(height: 8),
                  Text("Date: ${doctor.date}", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("Time: ${doctor.hour}", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

