import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view/add_doctor_scadule.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view/view_schedule_screen.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_appointment_screen.dart';


import '../../../core/utils/app_colors.dart';
import '../../doctor_home/presentation/doctor_home_screen.dart';
import '../../doctor_profile/presentation/view/doctor_profile_screen.dart';
import '../../user_home/presentation/view/user_home_screen.dart';
import '../../user_profile/presentation/view/profile_screen.dart';

class DoctorLayOut extends StatefulWidget {

  @override
  _DoctorLayOutState createState() => _DoctorLayOutState();
}

class _DoctorLayOutState extends State<DoctorLayOut> {
  int _selectedIndex = 0;

  static  final List<Widget> _screens = <Widget>[
    DoctorHomeScreen(userId: ''),
    ViewScheduleScreen(),
    DoctorProfileScreen(userId: ''),


  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary1,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),

        ],
      ),
    );
  }
}

