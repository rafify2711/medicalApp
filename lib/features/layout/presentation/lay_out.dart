import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/Profile/presentation/view/profile_screen.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_appointment_screen.dart';


import '../../../core/utils/app_colors.dart';
import '../../doctor_home/presentation/doctor_home_screen.dart';
import '../../user_home/presentation/view/user_home_screen.dart';

class UserLayOut extends StatefulWidget {
  static const routeName='lay_out.dart';
  @override
  _UserLayOutState createState() => _UserLayOutState();
}

class _UserLayOutState extends State<UserLayOut> {
  int _selectedIndex = 0;

  static  final List<Widget> _screens = <Widget>[
    UserHomeScreen(),
    UserAppointmentScreen(),
    ProfileScreen(token: '', userId: '')

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
        selectedItemColor: AppColors.primary,
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

// Sample Screens
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Home Screen')),
    );
  }
}

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctors')),
      body: Center(child: Text('Doctors Screen')),
    );
  }
}


class CleanerScreen extends StatelessWidget {
  const CleanerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('cleaner')),
      body: Center(child: Text('cleaner')),
    );
  }
}

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Record')),
      body: Center(child: Text('Record Screen')),
    );
  }
}