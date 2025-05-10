import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_appointment_screen.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';

import '../../../core/utils/app_colors.dart';
import '../../doctor_home/presentation/doctor_home_screen.dart';
import '../../user_home/presentation/view/user_home_screen.dart';
import '../../user_profile/presentation/view/profile_screen.dart';

class UserLayOut extends StatefulWidget {
  @override
  _UserLayOutState createState() => _UserLayOutState();
}

class _UserLayOutState extends State<UserLayOut> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
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
        selectedItemColor: AppColors.primary1,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: AppLocalizations.of(context).schedule,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppLocalizations.of(context).profile,
          ),
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
      appBar: AppBar(title: Text(AppLocalizations.of(context).home)),
      body: Center(child: Text(AppLocalizations.of(context).homeScreen)),
    );
  }
}

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).doctors)),
      body: Center(child: Text(AppLocalizations.of(context).doctorsScreen)),
    );
  }
}

class CleanerScreen extends StatelessWidget {
  const CleanerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).cleaner)),
      body: Center(child: Text(AppLocalizations.of(context).cleanerScreen)),
    );
  }
}

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).record)),
      body: Center(child: Text(AppLocalizations.of(context).recordScreen)),
    );
  }
}